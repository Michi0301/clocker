# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Clockout out', type: :request do
  describe 'A user clocks out' do
    let(:signin) { double('signin') }
    let(:clockout) { double('clockout') }
    let(:headers) { { 'ACCEPT' => 'application/json' } }
    let(:request) { post '/api/sage/clockout', params: { username: 'myuser', password: 'mypass' }, headers: headers }

    context 'Sign in at 3rd party succeeds' do
      before do
        allow(::Sage::Signin).to receive(:new).with(user: 'myuser', pass: 'mypass').and_return(signin)
        allow(signin).to receive(:call).and_return(true)
      end

      context 'Local logging' do
        before do
          allow(::Sage::Clockout).to receive(:new).and_return(clockout)
          allow(clockout).to receive(:call)
        end

        it 'Creates a user' do
          expect { request }.to change(User, :count).by(1)

          expect(User.last.name).to eq('myuser')
        end

        it 'Creates a clock event' do
          expect { request }.to change(ClockEvent, :count).by(1)

          expect(ClockEvent.last.event_type).to eq('clockout')
        end
      end

      context 'Clock in at 3rd party' do
        it 'Clocks in at the 3rd party' do
          expect(::Sage::Clockout).to receive(:new).and_return(clockout)
          expect(clockout).to receive(:call)

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

      it 'Does not clock out at the 3rd party' do
        expect(::Sage::Clockout).not_to receive(:new)

        request
      end
    end
  end
end
