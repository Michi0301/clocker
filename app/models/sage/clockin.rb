module Sage
  class Clockin
    include Support::Capybara

    CLOCKIN_ELEMENT_ID = '#ctl00_cphContent_terminal_btnKommen_CD'.freeze

    def call
      browser.find(CLOCKIN_ELEMENT_ID).click
      wait_for_ajax

      true
    end
  end
end
