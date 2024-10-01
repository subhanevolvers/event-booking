# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show]

  def index
    @bookings = current_user.bookings.includes(:event)
  end

  def new
    @event = Event.find(params[:event_id])
    @booking = current_user.bookings.new
    @available_tickets = @event.available_tickets
  end

  def create
    @event = Event.find(params[:booking][:event_id])
    @requested_tickets = params[:booking][:booked_tickets]

    service = BookingService.new(@event, @requested_tickets, current_user)
    result = service.create_booking
    if result[:success]
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = result[:error]
      render :new
    end
  end

  def show
    @event = @booking.event
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:event_id, :booked_tickets)
  end
end
