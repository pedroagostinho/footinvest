class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
  end

  def about
  end

  def feed
    @clubs = Club.all

    @results = Result.where(competition_id: 1).order(date_time: :desc).take(10)
    @results2 = Result.where(competition_id: 2).order(date_time: :desc).take(10)
    @results3 = Result.where(competition_id: 3).order(date_time: :desc).take(10)

    @news = New.order(date_time: :desc).take(5)

    @players = Player.all
  end

  def dashboard
  end

  def my_players

  end
end
