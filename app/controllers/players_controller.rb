class PlayersController < ApplicationController
  before_action :set_player, only: [:sell, :purchase, :buy, :show]
  layout 'chart', only:[:show]

  def index
    @players = []

    @transactions = Token.joins(:transactions)
                         .select('tokens.id,
                                  tokens.player_id,
                                  tokens.on_sale,
                                  tokens.owner,
                                  tokens.last_price,
                                  transactions.date_time,
                                  transactions.buying_user_id,
                                  transactions.price')
                         .order('transactions.date_time DESC,
                                 tokens.player_id DESC')
    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    @variation = Hash.new()

    sorted.uniq(&:player_id).each do |t|
      player_tokens = sorted.where(player_id: t.player_id)
      @variation[t.player_id] = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(2)
    end

    if params[:query].present? and params[:tokens].present?
      @list = Player.global_search(params[:query])
      @list.each do |pl|
        @players << pl if pl.tokens.where(on_sale: true).count >= params[:tokens].to_i
      end
      respond_to do |format|
        format.html { redirect_to players_path }
        format.js # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end

    elsif params[:query].present?
      @players = Player.global_search(params[:query])
      #@players = Player.where("name ILIKE ?", "%#{params[:name]}%")
      respond_to do |format|
        format.html { redirect_to players_path }
        format.js # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end

    elsif params[:tokens].present?
      Player.all.each do |pl|
        @players << pl if pl.tokens.where(on_sale: true).count >= params[:tokens].to_i
      end

      respond_to do |format|
        format.html { redirect_to players_path }
        format.js # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end
    else
      @players = Player.all #= Player.where.not(club_id: current_club.id, availability: false)
      respond_to do |format|
        format.html { render 'players/_index' }
        format.js # <-- idem
      end
    end
  end

  def show
    @player = Player.find(params[:id])

    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    player_tokens = sorted.where(player_id: @player.id)
    @variation = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(2)

    tokens_with_own = Token.where(player_id: params[:id], on_sale: true)
    @tokens = tokens_with_own.reject { |token| token.owner == current_user.id }

    @token_last_price = tokens_with_own.order(last_price: :DESC).last
  end

  def buy
    tokens_with_own = Token.where(player_id: params[:id], on_sale: true).order('last_price ASC')
    @tokens = tokens_with_own.reject { |token| token.owner == current_user.id }
  end

  def purchase
    nr_tokens = params[:player][:tokens].to_i

    tokens_with_own = Token.where(player_id: params[:id], on_sale: true).order('last_price ASC')
    @tokens = tokens_with_own.reject { |token| token.owner == current_user.id }

    @tokens_to_buy = @tokens.first(nr_tokens)

    total_amount = []
    current_transactions = Transaction.count

    @tokens_to_buy.each do |token|

      transaction = Transaction.new(date_time: DateTime.now,
                      price: token.last_price,
                      token_id: token.id,
                      buying_user_id: current_user.id,
                      selling_user_id: token.owner)
      transaction.save

      seller = User.find(token.owner)
      seller.balance += token.last_price
      seller.save
      # byebug
      token.update(on_sale: false)
      token.update(owner: current_user.id)

      total_amount << token.last_price
    end

    total_amount = total_amount.inject(0) { |sum, x| sum + x }

    current_user.balance = @balance - total_amount
    current_user.save

    if (current_transactions + @tokens_to_buy.count) == Transaction.count
      redirect_to my_players_path
    else
      render :buy
    end
  end

  def sell
    @tokens = Token.where(player_id: params[:id], on_sale: false, owner: current_user.id)
  end

  def selling
    nr_tokens = params[:player][:tokens].to_i
    price = params[:player][:transactions].to_i

    @tokens = Token.where(player_id: params[:id], on_sale: false, owner: current_user.id)

    @tokens_to_sell = @tokens.first(nr_tokens)

    @tokens_to_sell.each do |token|
      token.update(on_sale: true)
      token.update(last_price: price)
    end

    redirect_to my_players_path
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
