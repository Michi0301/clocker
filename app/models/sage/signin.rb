# frozen_string_literal: true

module Sage
  class Signin
    include Support::Capybara

    LOGIN_ELEMENT_ID = '#ctl00_cphContent_cmdLogin'
    PASS_FIELD = 'ctl00_cphContent_txtPassword_I'
    PRESENT_ELEMENT_AFTER_LOGIN = '#navBarCompanyInfo'
    SIGNIN_TIMEOUT = 20
    USER_FIELD = 'ctl00_cphContent_txtUsername_I'

    def initialize(user:, pass:)
      @user = user
      @pass = pass
    end

    def call
      ensure_clean_state!
      sign_in
    end

    private

    attr_reader :user, :pass

    def sign_in
      browser.visit Rails.configuration.x.sage_portal_url

      browser.fill_in(USER_FIELD, with: user)
      browser.fill_in(PASS_FIELD, with: pass)
      browser.find(LOGIN_ELEMENT_ID).click

      await_signin(browser)

      true
    rescue Timeout::Error, Capybara::ElementNotFound => e
      message = "Signin failed: #{e.message}"
      Rails.logger.fatal message

      raise message
    end

    def sign_in_successful?(browser)
      browser.find(PRESENT_ELEMENT_AFTER_LOGIN).present?
    end

    def await_signin(browser)
      Timeout.timeout(SIGNIN_TIMEOUT) do
        loop do
          break if sign_in_successful?(browser)

          sleep 0.2
        end
      end
    end
  end
end
