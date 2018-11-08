class ClockEvent < ApplicationRecord
  belongs_to :user

  enum event_type: { clock_in: 0, clock_out: 1 }

  validates :event_type, presence: true
end
