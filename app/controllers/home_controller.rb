class HomeController < ApplicationController
  before_action :set_reservation, only: [:index, :table_pdf]

  def index
    respond_to do |format|
      format.html
      format.js { render "booking_table" }
    end
  end

  def table_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "booking-#{@beginning_of_day.strftime("%d-%m-%Y")}",
                page_size: 'A4',
                encoding: 'utf-8',
                margin: { top: 5, left: 5, bottom: 5, right: 5 },
                template: "/home/table_pdf.html.erb",
                layout: "/booking_table_pdf.html.erb",
                locals: { reservations: @reservations, data: @beginning_of_day, meal: params[:meal] }
      end
    end
  end

  private

  def set_reservation
    date = params[:date] || Time.current.strftime("%d-%m-%Y")
    @beginning_of_day = Time.zone.parse(date).beginning_of_day
    lunch_time = @beginning_of_day.change(hour: 11, min: 30)..@beginning_of_day.change(hour: 15, min: 0)
    dinner_time = @beginning_of_day.change(hour: 16, min: 30)..@beginning_of_day.change(hour: 21, min: 30)
    @reservations = if params[:meal] == 'lunch'
      Reservation.includes(:user).where(booking_at: lunch_time ).order('booking_at ASC').group_by(&:table_number)
    elsif params[:meal] == 'dinner'
      Reservation.includes(:user).where(booking_at: dinner_time).order('booking_at ASC').group_by(&:table_number)
    end
  end
end
