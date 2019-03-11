class PlayersController < ApplicationController

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
    @player = Player.find(params[:id])

    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    player_tokens = sorted.where(player_id: @player.id)
    @variation = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(2)

    tokens_with_own = Token.where(player_id: params[:id], on_sale: true)
    @tokens = tokens_with_own.reject { |token| token.owner == current_user.id }

    @token_last_price = tokens_with_own.order(last_price: :DESC).last
  end
end





