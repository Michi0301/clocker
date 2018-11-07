module Api
  module Sage
    class ClockoutsController < BaseController
      def create
        ::Sage::Clockout.new.call
        render json: { success: true }, status: :created
      end
    end
  end
end
