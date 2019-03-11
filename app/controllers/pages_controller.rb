class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
  end

  def about
  end

  def feed
    @results1 = Result.where(competition_id: 1).order(date_time: :desc).take(10)
    @results2 = Result.where(competition_id: 2).order(date_time: :desc).take(10)
    @results3 = Result.where(competition_id: 3).order(date_time: :desc).take(10)

    @news = New.order(date_time: :desc).take(5)
    @players = Player.all

    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    @variation = Hash.new()

    sorted.uniq(&:player_id).each do |t|
      player_tokens = sorted.where(player_id: t.player_id)
      @variation[t.player_id] = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(2)
    end

    @variation_sorted_by_value = @variation.sort_by {|_key, value| value}.to_h

    @top_losers = @variation_sorted_by_value.first(5).to_h
    @vairation_reverse = @variation_sorted_by_value.to_a.reverse.to_h
    @top_winners = @vairation_reverse.first(5).to_h

    @stock_ticker_down =[]
    @stock_ticker_up =[]

    @variation_sorted_by_value.each do |key, value|
      if value > 0
        @stock_ticker_up << @players.where(id: key)[0].name
        @stock_ticker_up << value
        @stock_ticker_up << "%"
      else
        @stock_ticker_down << @players.where(id: key)[0].name
        @stock_ticker_down << value
        @stock_ticker_down << "%"
      end
    end

    @up = @stock_ticker_up.join(" ")
    @down = @stock_ticker_down.join(" ")

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
                        .uniq { |player| player.id }
    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    @variation = Hash.new()

    sorted.uniq(&:player_id).each do |t|
      player_tokens = sorted.where(player_id: t.player_id)
      @variation[t.player_id] = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(2)
    end
  end
end
