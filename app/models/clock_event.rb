class ClockEvent < ApplicationRecord
  belongs_to :user

  validates :event_type, presence: true
end
