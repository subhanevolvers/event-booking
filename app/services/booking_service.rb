class BookingService
  attr_reader :event, :requested_tickets, :user

  def initialize(event, requested_tickets, user)
    @event = event
    @requested_tickets = requested_tickets
    @user = user
  end

  def create_booking
    ActiveRecord::Base.transaction do
      available_tickets = Rails.cache.fetch("available_tickets_#{event.id}") do
        event.available_tickets
      end

      if available_tickets >= requested_tickets.to_i
        create_and_save_booking
        update_available_tickets_in_cache
        return { success: true, booking: @booking }
      else
        return { success: false, error: "Not enough tickets available. Only #{available_tickets} tickets left." }
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    { success: false, error: e.message }
  rescue => e
    Rails.logger.error("BookingService Error: #{e.message}")
    { success: false, error: "An unexpected error occurred. Please try again." }
  end

  private

  def create_and_save_booking
    @booking = event.bookings.new(booked_tickets: requested_tickets, user: user)
    @booking.save!
  end

  def update_available_tickets_in_cache
    event.available_tickets -= requested_tickets.to_i
    event.save!
    #Rails.cache.write("available_tickets_#{event.id}", event.available_tickets, expires_in: 20.minutes)
  end
end
