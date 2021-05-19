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

  def table_pdf
    date = params[:date] || Time.current.strftime("%d-%m-%Y")
    beginning_of_day = Time.zone.parse(date).beginning_of_day
    end_of_day = Time.zone.parse(date).end_of_day
    @reservations = Reservation.includes(:user).where(booking_at: beginning_of_day..end_of_day).order('booking_at ASC').group_by(&:table_number)
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "booking-#{beginning_of_day.strftime("%d-%m-%Y")}",
                page_size: 'A4',
                encoding: 'utf-8',
                margin: { top: 5, left: 5, bottom: 5, right: 5 },
                template: "/home/table_pdf.html.erb",
                layout: "/booking_table_pdf.html.erb",
                locals: { reservations: @reservations, data: beginning_of_day }
      end
    end
  end
end
