class TransactionsController < ApplicationController

  def new
    @user = current_user
    @player = Player.find(params[:player_id])
    @transaction = Transaction.new
  end

  def create
    @user = current_user
    @player = Player.find(params[:player_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.player = @player
    @transaction.user = @user

    if @booking.save
      @player.update(availability: false)
      @player.update(club: @club)
      redirect_to my_players_path
    else
      render :new
    end
  end

  private
end

# transaction: date_time, price, token_id, buying_user_id, selling_user_id
# token: on_sale, last_price, owner
# user: balance
