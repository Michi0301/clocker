# frozen_string_literal: true

class BaseSageJob < ApplicationJob
  queue_as :default

  def perform(username:, password:, push_token: nil)
    signin(username, password)
    execute_action(push_token)
  end

  private

  def signin(username, password)
    ::Sage::Signin.new(user: username, pass: password).call
  end

  def execute_action(push_token)
    raise NotImplementedError, 'Method must be defined in subclass.'
  end
end
