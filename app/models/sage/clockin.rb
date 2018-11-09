module Sage
  class Clockin
    include Support::Capybara

    CLOCKIN_ELEMENT_ID = '#ctl00_cphContent_terminal_btnKommen'.freeze

    def call
      browser.find(CLOCKIN_ELEMENT_ID).click
      wait_for_ajax

      true
      rescue Capybara::ElementNotFound => e
        message = "Clockin failed: #{e.message}"
        Rails.logger.fatal message

        fail RuntimeError, message
    end
  end
end
