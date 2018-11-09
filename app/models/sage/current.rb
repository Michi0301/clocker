module Sage
  class Current
    include Support::Capybara

    CURRENT_STATE_ELEMENT_ID = '#ctl00_cphContent_terminal_lblStatus'.freeze

    def call
      browser.find(CURRENT_STATE_ELEMENT_ID).text

      rescue Capybara::ElementNotFound => e
        message = "Fetching current status failed: #{e.message}"
        Rails.logger.fatal message

        fail RuntimeError, message
    end
  end
end
