class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_balance

  def user_balance
    @balance = User.find(current_user.id).balance if current_user.present?
  end
end
