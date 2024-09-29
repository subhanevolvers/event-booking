class Event < ApplicationRecord
  belongs_to :user, optional: true
  validates :name , uniqueness:true
end
