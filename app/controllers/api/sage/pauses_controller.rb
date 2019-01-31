# frozen_string_literal: true

module Api
  module Sage
    class PausesController < BaseController
      def create
        if perform_synchronous?
          PauseJob.perform_now(username: username, password: password)
          render json: { success: true, current_state: ::Sage::Current.new.call }, status: :created
        else
          PauseJob.perform_later(username: username, password: password, push_token: params[:push_token])
          render json: { success: true }, status: :created
        end
      end
    end
  end
end
