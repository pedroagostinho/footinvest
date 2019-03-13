class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]
  layout 'chart', only: [:my_players]


  def home
  end

  def about
  end

  def feed

    @results1 = Competition.first.latest_results
    @results2 = Competition.second.latest_results
    @results3 = Competition.third.latest_results

    @news = New.order(date_time: :desc).take(5)
    @players = Player.all

    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    @variation = Hash.new()

    sorted.uniq(&:player_id).each do |t|
      player_tokens = sorted.where(player_id: t.player_id)

      if player_tokens.first.nil? || player_tokens.second.nil?
        @variation[t.player_id] = 0
      else
        @variation[t.player_id] = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(1)
      end
    end

    @variation_sorted_by_value = @variation.sort_by {|_key, value| value}.to_h

    @top_losers = @variation_sorted_by_value.first(5).to_h
    @vairation_reverse = @variation_sorted_by_value.to_a.reverse.to_h
    @top_winners = @vairation_reverse.first(5).to_h

    @img_array = FrontpageService.call


    @stock_ticker_down =[]
    @stock_ticker_up =[]

    @variation_sorted_by_value.each do |key, value|
      if value > 0
        @stock_ticker_up << @players.where(id: key)[0].name
        @stock_ticker_up << value
        @stock_ticker_up << "%"
        #@stock_ticker_up << "           "
      else
        @stock_ticker_down << @players.where(id: key)[0].name
        @stock_ticker_down << value
        @stock_ticker_down << "%"
        #@stock_ticker_down << "          "
      end
    end
#byebug
    @up = @stock_ticker_up.join(' ').gsub!("% ", "%                                                      ")
    @down = @stock_ticker_down.join(' ').gsub!("% ", "%                                                     ")
  end

  def my_players
    # @my_tokens = Token.where(owner: current_user)
    @transactions = Token.joins(:transactions)
                         .select('tokens.id,
                                  tokens.player_id,
                                  tokens.owner,
                                  transactions.date_time,
                                  transactions.buying_user_id,
                                  transactions.price')
                         .order('transactions.date_time DESC,
                                 tokens.player_id DESC')

    @my_transactions = Transaction.where(buying_user_id: current_user.id)
                                  .or(Transaction.where(selling_user_id: current_user.id))
                                  .order('date_time ASC')
    values = []
    @my_transactions.each do |transaction|
      if transaction.buying_user_id == current_user.id
        values << transaction.price
      elsif transaction.selling_user_id == current_user.id
        values << (transaction.price) * -1
      end
      @portfolio_values = values.each_with_object([]){|e, a| a.push(a.last.to_i + e)}
    end
    @portfolio = Hash.new()
    @my_transactions.each_with_index do |t, i|
      @portfolio[t.date_time] = @portfolio_values[i]
    end
    @portfolio

    @my_players = Player.joins(:tokens)
                        .where(tokens: { owner: current_user })
                        .uniq { |player| player.id }
    sorted = Token.joins(:transactions).select('tokens.id, tokens.player_id, transactions.date_time, transactions.price').order('transactions.date_time DESC, tokens.player_id ASC')

    @variation = Hash.new()

    sorted.uniq(&:player_id).each do |t|
      player_tokens = sorted.where(player_id: t.player_id)
      if player_tokens.first.nil? || player_tokens.second.nil?
        @variation[t.player_id] = 0
      else
        @variation[t.player_id] = (((player_tokens.first.price - player_tokens.second.price) / player_tokens.second.price.to_f) * 100).round(1)
      end
    end


    @portfolio_percentage = Hash.new()
    total_value = []

    @transactions.each do |transaction|
      total_value << transaction.price if transaction.buying_user_id == transaction.owner && transaction.buying_user_id == current_user.id
    end
      t_v = total_value.sum
      v_player = 0

    @my_players.each do |player|
      @tokens_total_value = []

      @transactions.each do |transaction|
        @tokens_total_value << transaction.price if transaction.buying_user_id == transaction.owner && transaction.buying_user_id == current_user.id && transaction.player_id == player.id
      end
      v_player = @tokens_total_value.sum
      @portfolio_percentage[player.name] = (v_player.to_f / t_v.to_f * 100).round(2)
    end

    @pie_chart = @portfolio_percentage.first(7).to_h
    @pie_chart["Others"] = (100 - @pie_chart.sum { |k, v| v }).round(2)
  end

  def my_transactions

    @my_transactions = Transaction.where(buying_user_id: current_user.id)
                                  .or(Transaction.where(selling_user_id: current_user.id))
                                  .order('date_time DESC')
  end
end
