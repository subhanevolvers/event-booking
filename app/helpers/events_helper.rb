# frozen_string_literal: true

module EventsHelper
  def available_tickets(event)
    event.tickets_availability
  end
end
