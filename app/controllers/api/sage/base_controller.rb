module Api
  module Sage
    class BaseController < ActionController::API
      before_action :signin, only: :create
      rescue_from RuntimeError, with: :render_error

      private

      def signin
        fail RuntimeError, 'Signin failed at 3rd party.' unless ::Sage::Signin.new(user: sign_in_params[:username], pass: sign_in_params[:password]).call
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
