# frozen_string_literal: true

class User < ApplicationRecord
  has_many :clock_events

  validates :name, presence: true
end
