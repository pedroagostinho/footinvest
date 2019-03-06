class PlayersController < ApplicationController
  def index
    if params[:query].present?
      @players = Player.global_search(params[:query])#.where.not(club_id: current_club.id)
    else
      @players = Player.all #= Player.where.not(club_id: current_club.id, availability: false)
    end
  end

  def show
  end
end
