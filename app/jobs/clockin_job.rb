# frozen_string_literal: true

class ClockinJob < BaseSageJob
  private

  def execute_action(push_token)
    result =  ::Sage::Clockin.new.call

    if push_token
      SendNotification.new(
        push_token: push_token,
        action: :clockin,
        current_status: ::Sage::Current.new.call
      ).call
    end

    result
  end
end
