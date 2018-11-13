# frozen_string_literal: true

module Api
  module Sage
    class PausesController < BaseController
      def create
        PauseJob.perform_later(username: username, password: password)
        render json: { success: true }, status: :created
      end
    end
  end
end
