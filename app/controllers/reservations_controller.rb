class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    respond_to do |format|
      format.html
      format.json { render json: @reservations.includes(:user).to_json({include: { user: { only: [:name, :mobile]}}}) }
    end
  end
  def new
    @reservation = Reservation.new
    @user = User.new
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.save!
    redirect_to reservations_path
  end

  def edit
    @reservation = Reservation.first
  end

  private

  def reservation_params
    params.require(:reservation).permit(:number_of_customer, :table_number, :remark, :booking_at, user_attributes: [:name, :email, :mobile])
  end
end
