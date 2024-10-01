# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: true
  has_many :bookings

  after_commit :cache_available_tickets

  def cache_available_tickets
    Rails.cache.write("available_tickets_#{id}", available_tickets, expires_in: 20.minutes)
  end

  def tickets_availability
    Rails.cache.fetch("available_tickets_#{id}", expires_in: 20.minutes) do
      available_tickets
    end
  end
end
