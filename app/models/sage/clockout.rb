# frozen_string_literal: true

module Sage
  class Clockout < BaseAction
    private

    def action_element
      '#ctl00_cphContent_terminal_btnGehen'
    end
  end
end
