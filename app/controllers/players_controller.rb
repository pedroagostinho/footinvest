class PlayersController < ApplicationController


  def index
    if (params[:name].present? || params[:tokens].present?)
      # @players = Player.global_search(params[:query])
      @players = Player.where("name ILIKE ?", "%#{params[:name]}%")
      @players = Token.where(owner: nil).count <= params[:token]

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
    @competition = Competition.find(params[:id])
    @stat = Stat.find(params[:id])
  end

end
