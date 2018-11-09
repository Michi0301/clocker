require 'rails_helper'

RSpec.feature 'Clocking in', type: :request do
  describe 'A user clocks in' do
    let(:signin) { double('signin') }
    let(:clockin) { double('clockin') }
    let(:headers) { {'ACCEPT' => 'application/json'} }
    let(:request) { post '/api/sage/clockin', params: { username: 'myuser', password: 'mypass' }, headers: headers }

    context 'Sign in at 3rd party succeeds' do
      before do
        allow(::Sage::Signin).to receive(:new).with(user: 'myuser', pass: 'mypass').and_return(signin)
        allow(signin).to receive(:call).and_return(true)
      end

      context 'Local logging' do
        before do
          allow(::Sage::Clockin).to receive(:new).and_return(clockin)
          allow(clockin).to receive(:call)
        end

        it 'Creates a user' do
          expect { request }.to change(User, :count).by(1)

          expect(User.last.name).to eq('myuser')
        end

        it 'Creates a clock event' do
          expect { request }.to change(ClockEvent, :count).by(1)

          expect(ClockEvent.last.event_type).to eq('clockin')
        end
      end

      context 'Clock in at 3rd party' do
        it 'Clocks in at the 3rd party' do
          expect(::Sage::Clockin).to receive(:new).and_return(clockin)
          expect(clockin).to receive(:call)

          request
        end
      end
    end

    context 'Sign in at 3rd party fails' do
      before do
        allow(::Sage::Signin).to receive(:new).with(user: 'myuser', pass: 'mypass').and_return(signin)
        allow(signin).to receive(:call).and_raise(RuntimeError)
      end

      it 'Creates a user' do
        expect { request }.to change(User, :count).by(1)

        expect(User.last.name).to eq('myuser')
      end

      it 'Creates a clock event' do
        expect { request }.to change(ClockEvent, :count).by(1)
      end

      it 'Does not clock in at the 3rd party' do
        expect(::Sage::Clockin).not_to receive(:new)

        request
      end
    end
  end
end
