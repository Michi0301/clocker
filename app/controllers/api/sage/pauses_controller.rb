# frozen_string_literal: true

module Api
  module Sage
    class PausesController < BaseController
      def create
        ::Sage::Pause.new.call
        render json: { success: true }, status: :created
      end
    end
  end
end
