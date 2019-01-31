# frozen_string_literal: true

class ClockoutJob < BaseSageJob
  private

  def execute_action(push_token)
    result =  ::Sage::Clockout.new.call

    if push_token
      SendNotification.new(
        push_token: push_token,
        action: :clockout,
        current_status: ::Sage::Current.new.call
      ).call
    end

    result
  end
end
