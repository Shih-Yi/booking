class ReservationsController < ApplicationController
  def index
  end
  def new
    @reservation = Reservation.new
    @user = User.new
  end

  def create
    byebug
  end

  def edit
    @reservation = Reservation.first
  end

  private

  def reservation_params
    params.require(:reservation).permit(:order_number, :booking_at, user_attributes: [:name, :email, :mobile])
  end
end
