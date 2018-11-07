module Api
  module Sage
    class CurrentsController < BaseController
      def create
        state = ::Sage::Current.new.call
        render json: { success: true, current_state: state}, status: :created
      end
    end
  end
end
