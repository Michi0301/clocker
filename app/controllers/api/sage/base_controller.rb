# frozen_string_literal: true

module Api
  module Sage
    class BaseController < ActionController::API
      include ::ActionController::HttpAuthentication::Basic

      before_action :log_activity
      rescue_from RuntimeError, with: :render_error

      private

      def signin
        ::Sage::Signin.new(user: username, pass: password).call
      end

      def basic_auth_username
        user_name_and_password(request).first
      end

      def basic_auth_password
        user_name_and_password(request).last
      end

      def username
        sign_in_params[:username].presence || basic_auth_username.presence
      end

      def password
        sign_in_params[:password].presence || basic_auth_password.presence
      end

      def log_activity
        current_user = User.find_or_create_by(name: username)

        ClockEvent.create!(user: current_user, event_type: controller_name.singularize)
      end

      def sign_in_params
        params.permit(:username, :password, :push_token)
      end

      def render_error(error)
        render json: { success: false, message: error.message }, status: :service_unavailable
      end

      def perform_synchronous?
        params[:perform_sync].present?
      end
    end
  end
end
