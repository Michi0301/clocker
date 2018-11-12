# frozen_string_literal: true

module Sage
  class BaseAction
    include Support::Capybara

    def call
      browser.find(action_element).click
      wait_for_ajax

      true
    rescue Capybara::ElementNotFound => e
      message = "#{self.class.name} failed: #{e.message}"
      Rails.logger.fatal message

      raise message
    end

    private

    def action_element
      raise NotImplementedError, 'Method must be defined in subclass.'
    end
  end
end
