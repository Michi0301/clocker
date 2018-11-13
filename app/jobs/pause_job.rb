class PauseJob < BaseSageJob
  private

  def execute_action
    ::Sage::Pause.new.call
  end
end
