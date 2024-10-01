class BookingService
  attr_reader :event, :requested_tickets, :user

  def initialize(event, requested_tickets, user)
    @event = event
    @requested_tickets = requested_tickets
    @user = user
  end

  def create_booking
    ActiveRecord::Base.transaction do
      event.lock!

      available_tickets = Rails.cache.fetch("available_tickets_#{event.id}") do
        event.available_tickets
      end

      if available_tickets < requested_tickets.to_i
        raise StandardError, "Not enough tickets available. Only #{available_tickets} left."
      end

      booking = create_and_save_booking

      update_available_tickets(booking.booked_tickets)

      { success: true, booking: booking }
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Booking creation failed: #{e.message}")
    { success: false, error: e.message }
  rescue => e
    Rails.logger.error("Transaction failed: #{e.message}")
    { success: false, error: "An unexpected error occurred. Please try again." }
  end

  private

  def create_and_save_booking
    booking = event.bookings.new(booked_tickets: requested_tickets, user: user)
    booking.save!
    booking
  end

  def update_available_tickets(tickets_booked)
    event.available_tickets -= tickets_booked
    event.save!
    Rails.cache.delete("available_tickets_#{event.id}")
  end
end
