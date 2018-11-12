# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockEvent, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:event_type) }
  end
end
