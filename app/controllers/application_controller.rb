class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_balance
  before_action :divisor
  before_action :configure_permitted_parameters, if: :devise_controller?


  def user_balance
    if current_user.nil?
      @balance = 0
    elsif current_user != nil
      @balance = User.find(current_user.id).balance
    end

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



  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :postcode])

    # For additional in app/views/devise/registrations/edit.html.erb
    #devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
