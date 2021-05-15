class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :destroy]

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
    flash[:success] = "Successfully"
    redirect_to reservations_path
  end

  def edit
  end

  def update
    @reservation.update(reservation_params)
    flash[:success] = "Successfully"
    redirect_to reservations_path
  end

  def destroy
    @reservation.destroy
    render status: 200, json: { result: "Deleted Successfully" }
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:number_of_customer, :table_number, :remark, :booking_at, user_attributes: [:name, :email, :mobile])
  end
end
