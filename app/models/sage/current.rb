module Sage
  class Current
    include Support::Capybara

    CURRENT_STATE_ELEMENT_ID = '#ctl00_cphContent_terminal_lblStatus'.freeze

    def call
      browser.find(CURRENT_STATE_ELEMENT_ID).text
    end
  end
end
