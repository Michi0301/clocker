# frozen_string_literal: true

module Api
  module Sage
    class ClockoutsController < BaseController
      def create
        ClockoutJob.perform_later(username: username, password: password)

        render json: { success: true }, status: :created
      end
    end
  end
end
