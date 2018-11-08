require 'rails_helper'

RSpec.describe ClockEvent, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to define_enum_for(:event_type) }
  end
end
