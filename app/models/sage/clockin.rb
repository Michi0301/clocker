# frozen_string_literal: true

module Sage
  class Clockin < BaseAction
    private

    def action_element
      '#ctl00_cphContent_terminal_btnKommen'
    end
  end
end
