class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
  end

  def about
  end

  def feed
    @results = Result.where(competition_id: 1).order(date_time: :desc).take(10)
    @results2 = Result.where(competition_id: 2).order(date_time: :desc).take(10)
    @results3 = Result.where(competition_id: 3).order(date_time: :desc).take(10)

    @news = New.order(date_time: :desc).take(5)

    @players = Player.all
  end

  def dashboard
  end

  def my_players
    # @my_tokens = Token.where(owner: current_user)
    @transactions = Token.joins(:transactions)
                         .select('tokens.id,
                                  tokens.player_id,
                                  transactions.date_time,
                                  transactions.price')
                         .order('transactions.date_time DESC,
                                 tokens.player_id DESC')

    @my_players = Player.joins(:tokens)
                        .where(tokens: { owner: current_user })

    @my_players2 = Player.joins(:tokens)
                         .where(tokens: { owner: current_user })
                         .select('tokens.id,
                                  tokens.on_sale,
                                  tokens.last_price,
                                  tokens.player_id,
                                  tokens.owner,
                                  players.name,
                                  players.photo,
                                  players.age,
                                  players.height,
                                  players.nationality,
                                  players.position,
                                  players.social_url,
                                  players.club_id')
  end
end
