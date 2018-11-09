module Sage
  class Clockout
    include Support::Capybara

    CLOCKOUT_ELEMENT_ID = '#ctl00_cphContent_terminal_btnGehen'.freeze

    def call
      browser.find(CLOCKOUT_ELEMENT_ID).click
      wait_for_ajax

      true
      rescue Capybara::ElementNotFound => e
        message = "Clockout failed: #{e.message}"
        Rails.logger.fatal message

        fail RuntimeError, message
    end
  end
end
