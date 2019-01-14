# frozen_string_literal: true

module Support
  module Capybara
    def browser
      @browser ||= ::Capybara.current_session
    end

    def wait_for_ajax
      Timeout.timeout(::Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def finished_all_ajax_requests?
      browser.evaluate_script('jQuery.active').zero?

      sleep 0.2
    end

    def ensure_clean_state!
      ::Capybara.reset_sessions!
    end
  end
end
