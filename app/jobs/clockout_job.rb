class ClockoutJob < BaseSageJob
  private

  def execute_action
    ::Sage::Clockout.new.call
  end
end
