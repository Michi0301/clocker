# frozen_string_literal: true

module Sage
  class Current
    include Support::Capybara

    CURRENT_STATE_ELEMENT_ID = '#ctl00_cphContent_terminal_lblStatus'

    def call
      browser.find(CURRENT_STATE_ELEMENT_ID).text
    rescue Capybara::ElementNotFound => e
      message = "Fetching current status failed: #{e.message}"
      Rails.logger.fatal message

      raise message
    end
  end
end
