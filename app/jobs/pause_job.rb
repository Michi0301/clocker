# frozen_string_literal: true

class PauseJob < BaseSageJob
  private

  def execute_action(push_token)
    result = ::Sage::Pause.new.call

    if push_token
      SendNotification.new(
        push_token: push_token,
        action: :pause,
        current_status: ::Sage::Current.new.call
      ).call

      result
    end
  end
end
