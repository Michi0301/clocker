# frozen_string_literal: true

class ClockinJob < BaseSageJob
  private

  def execute_action
    ::Sage::Clockin.new.call
  end
end
