# frozen_string_literal: true

module Sage
  class Pause < BaseAction
    private

    def action_element
      '#ctl00_cphContent_terminal_btnPause'
    end
  end
end
