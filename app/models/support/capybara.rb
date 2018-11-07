module Support
  module Capybara
    def browser
      @browser ||= ::Capybara.current_session
    end
  end
end
