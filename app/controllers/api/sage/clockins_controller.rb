module Api
  module Sage
    class ClockinsController < BaseController
      before_action :log_activity

      def create
        ::Sage::Clockin.new.call
        render json: { success: true }, status: :created
      end
    end
  end
end
