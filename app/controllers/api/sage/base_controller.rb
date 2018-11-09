module Api
  module Sage
    class BaseController < ActionController::API
      before_action :log_activity
      before_action :signin, only: :create
      rescue_from RuntimeError, with: :render_error

      private

      def signin
        ::Sage::Signin.new(user: sign_in_params[:username], pass: sign_in_params[:password]).call
      end

      def log_activity
        current_user = User.find_or_create_by name: sign_in_params[:username]

        ClockEvent.create!(user: current_user, event_type: controller_name.singularize)
      end

      def sign_in_params
        params.permit(:username, :password)
      end

      def render_error(error)
        render json: { success: false, message: error.message }, status: :service_unavailable
      end
    end
  end
end
