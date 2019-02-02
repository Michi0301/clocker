class SendNotification
  APP_NAME = 'clocker-client'.freeze

  def initialize(push_token:, action:, current_status:)
    @push_token = push_token
    @action = action
    @current_status = current_status
  end


  def call
    notification = Rpush::Gcm::Notification.new
    notification.app = Rpush::Gcm::App.find_by_name(APP_NAME)

    notification.registration_ids = [push_token]
    notification.notification = { body: message, title: 'Clocker' }
    notification.data = { action: action, current_status: current_status }
    notification.save!
  end

  private

  attr_reader :push_token, :action, :current_status

  def message
    "#{action.to_s.titleize} finished. New status: #{current_status}."
  end
end
