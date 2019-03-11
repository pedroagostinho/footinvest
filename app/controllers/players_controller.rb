class PlayersController < ApplicationController
  before_action :set_player, only: [:sell, :purchase, :buy, :show]

  def index
    @players = []
    if params[:query].present? and params[:tokens].present?
      @list = Player.global_search(params[:query])
      @list.each do |pl|
        @players << pl if pl.tokens.where(on_sale: true).count >= params[:tokens].to_i
      end
      respond_to do |format|
        format.html { redirect_to players_path }
        format.js  # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end

    elsif params[:query].present?
      @players = Player.global_search(params[:query])
      #@players = Player.where("name ILIKE ?", "%#{params[:name]}%")
      respond_to do |format|
        format.html { redirect_to players_path }
        format.js  # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end

    elsif params[:tokens].present?
      Player.all.each do |pl|
        @players << pl if pl.tokens.where(on_sale: true).count >= params[:tokens].to_i
      end

      respond_to do |format|
        format.html { redirect_to players_path }
        format.js  # <-- will render `app/views/players/index.js.erb#.where.not(club_id: current_club.id)
      end
    else
      @players = Player.all #= Player.where.not(club_id: current_club.id, availability: false)
      respond_to do |format|
        format.html { render 'players/index' }
        format.js  # <-- idem
      end
    end

  end

  def show
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

    @tokens_to_buy.each do |token|
      # byebug

      Transaction.new(date_time: DateTime.now,
                      price: token.last_price,
                      token_id: token.id,
                      buying_user_id: current_user.id,
                      selling_user_id: token.owner).save

      token.update(on_sale: false)
      token.update(owner: current_user.id)

      total_amount << token.last_price
    end

    total_amount = total_amount.inject(0) { |sum, x| sum + x }

    user = current_user

    user.balance = user.balance - total_amount

    # respond_to do |format|
    #   format.js  # <-- idem
    # end

    # if Transaction.new.save
    #   redirect_to player_path(@player)
    # else
    #   render :buy
    # end

  end

  def sell
    @tokens = Token.where(player_id: params[:id], on_sale: false, owner: current_user.id)
  end


  def set_player
    @player = Player.find(params[:id])

  end
end
