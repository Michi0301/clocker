# frozen_string_literal: true

class ClockEvent < ApplicationRecord
  belongs_to :user

  validates :event_type, :user, presence: true
end
