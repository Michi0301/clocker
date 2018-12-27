# frozen_string_literal: true

class PauseJob < BaseSageJob
  private

  def execute_action
    ::Sage::Pause.new.call
  end
end
