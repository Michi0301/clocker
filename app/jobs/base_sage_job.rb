# frozen_string_literal: true

class BaseSageJob < ApplicationJob
  queue_as :default

  def perform(username:, password:)
    signin(username, password)
    execute_action
  end

  private

  def signin(username, password)
    ::Sage::Signin.new(user: username, pass: password).call
  end

  def execute_action
    raise NotImplementedError, 'Method must be defined in subclass.'
  end
end
