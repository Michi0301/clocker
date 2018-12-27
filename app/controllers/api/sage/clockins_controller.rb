# frozen_string_literal: true

module Api
  module Sage
    class ClockinsController < BaseController
      def create
        if perform_synchronous?
          ClockinJob.perform_now(username: username, password: password)
          render json: { success: true, current_state: ::Sage::Current.new.call }, status: :created
        else
          ClockinJob.perform_later(username: username, password: password)
          render json: { success: true }, status: :created
        end
      end
    end
  end
end
