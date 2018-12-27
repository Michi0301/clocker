# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Clocking in', type: :request do
  include SignInHelper

  describe 'A user clocks in' do
    let(:signin) { double('signin') }
    let(:clockin) { double('clockin') }
    let(:headers) { { 'ACCEPT' => 'application/json' } }
    let(:perform_request) do
      post '/api/sage/clockin',
           params: { username: 'myuser', password: 'mypass', perform_sync: perform_sync },
           headers: headers
    end

    context 'async execution' do
      let(:perform_sync) { nil }

      context 'Sign in at 3rd party succeeds' do
        before { mock_successful_signin }

        context 'Local logging' do
          before do
            allow(::Sage::Clockin).to receive(:new).and_return(clockin)
            allow(clockin).to receive(:call)
          end

          it 'Creates a user' do
            expect { perform_request }.to change(User, :count).by(1)

            expect(User.last.name).to eq('myuser')
          end

          it 'Creates a clock event' do
            expect { perform_request }.to change(ClockEvent, :count).by(1)

            expect(ClockEvent.last.event_type).to eq('clockin')
          end
        end

        context 'Clock in at 3rd party' do
          it 'Clocks in at the 3rd party' do
            expect(::Sage::Clockin).to receive(:new).and_return(clockin)
            expect(clockin).to receive(:call)

            perform_request
          end
        end
      end

      context 'Sign in at 3rd party fails' do
        before { mock_failed_signin }

        it 'Creates a user' do
          expect { perform_request }.to change(User, :count).by(1)

          expect(User.last.name).to eq('myuser')
        end

        it 'Creates a clock event' do
          expect { perform_request }.to change(ClockEvent, :count).by(1)
        end
      end
    end

    context 'sync execution' do
      let(:perform_sync) { true }
      let(:current) { double('current') }

      before do
        mock_successful_signin

        allow(::Sage::Clockin).to receive(:new).and_return(clockin)
        allow(clockin).to receive(:call)
        allow(::Sage::Current).to receive(:new).and_return(current)
        allow(current).to receive(:call).and_return('some-state')
      end

      it 'includes the current state' do
        perform_request

        expect(JSON.parse(response.body)).to eq('success' => true, 'current_state' => 'some-state')
      end
    end
  end
end
