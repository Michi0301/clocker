# frozen_string_literal: true

module Api
  module Sage
    class BaseController < ActionController::API
      include ::ActionController::HttpAuthentication::Basic

      before_action :log_activity
      before_action :signin, only: :create
      rescue_from RuntimeError, with: :render_error

      private

      def signin
        basic_auth_username, basic_auth_password = user_name_and_password(request)

        if basic_auth_username.present? && basic_auth_password.present?
          ::Sage::Signin.new(user: basic_auth_username, pass: basic_auth_password).call
        else
          ::Sage::Signin.new(user: sign_in_params[:username], pass: sign_in_params[:password]).call
        end
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
