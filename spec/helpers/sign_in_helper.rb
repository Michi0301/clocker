# frozen_string_literal: true

module SignInHelper
  def mock_successful_signin
    allow(::Sage::Signin).to receive(:new).with(user: 'myuser', pass: 'mypass').and_return(signin)
    allow(signin).to receive(:call).and_return(true)
  end

  def mock_failed_signin
    allow(::Sage::Signin).to receive(:new).with(user: 'myuser', pass: 'mypass').and_return(signin)
    allow(signin).to receive(:call).and_raise(RuntimeError)
  end
end
