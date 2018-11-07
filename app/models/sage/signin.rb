module Sage
  class Signin
    LOGIN_ELEMENT_ID = '#ctl00_cphContent_cmdLogin'.freeze
    PASS_FIELD = 'ctl00_cphContent_txtPassword_I'.freeze
    PORTAL_URL = 'https://portal106427097.bpo-sage.de/mportal'.freeze
    PRESENT_ELEMENT_AFTER_LOGIN = '#navBarCompanyInfo'.freeze
    SIGNIN_TIMEOUT = 10.freeze
    USER_FIELD = 'ctl00_cphContent_txtUsername_I'.freeze

    def initialize(user:, pass:)
      @user = user
      @pass = pass
    end

    def call
      browser.visit PORTAL_URL

      browser.fill_in(USER_FIELD, with: user)
      browser.fill_in(PASS_FIELD, with: pass)
      browser.find(LOGIN_ELEMENT_ID).click

      await_signin(browser)

      true
    rescue Timeout::Error
      false
    end

    private

    attr_reader :user, :pass

    def browser
      @browser ||= Capybara.current_session
    end

    def sign_in_successful?(browser)
      browser.find(PRESENT_ELEMENT_AFTER_LOGIN).present?
    end

    def await_signin(browser)
      Timeout.timeout(SIGNIN_TIMEOUT) do
        loop do
          break if sign_in_successful?(browser)

          sleep 1
        end
      end
    end
  end
end
