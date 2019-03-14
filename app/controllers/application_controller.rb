class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_balance
  before_action :divisor

  def user_balance
    @balance = User.find(current_user.id).balance if current_user.present?
    if @balance.negative?
      @balance = 0
    else
      @balance = User.find(current_user.id).balance if current_user.present?
    end
  end

  def divisor
    @user_count = User.count
    @player_count = Player.count
    @total_value = Transaction.sum(:price)
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end
end
