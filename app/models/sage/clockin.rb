# frozen_string_literal: true

module Sage
  class Clockin
    include Support::Capybara

    CLOCKIN_ELEMENT_ID = '#ctl00_cphContent_terminal_btnKommen'

    def call
      browser.find(CLOCKIN_ELEMENT_ID).click
      wait_for_ajax

      true
    rescue Capybara::ElementNotFound => e
      message = "Clockin failed: #{e.message}"
      Rails.logger.fatal message

      raise message
    end
  end
end
