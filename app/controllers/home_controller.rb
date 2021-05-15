class HomeController < ApplicationController

  def index
    date = params[:date] || Time.current.strftime("%d-%m-%Y")
    beginning_of_day = Time.zone.parse(date).beginning_of_day
    end_of_day = Time.zone.parse(date).end_of_day
    @reservations = Reservation.includes(:user).where(booking_at: beginning_of_day..end_of_day).order('booking_at ASC').group_by(&:table_number)
    respond_to do |format|
      format.html
      format.js { render "booking_table" }
    end
  end
end
