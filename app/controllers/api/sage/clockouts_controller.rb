module Api
  module Sage
    class ClockoutsController < BaseController
      before_action :log_activity

      def create
        ::Sage::Clockout.new.call
        render json: { success: true }, status: :created
      end
    end
  end
end
