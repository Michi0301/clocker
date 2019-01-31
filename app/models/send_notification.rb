class SendNotification
  APP_NAME = 'clocker-client'.freeze

  def initialize(registration_ids:, message:)
    @registration_ids = registration_ids
    @message = message
  end

  attr_reader :message, :registration_ids

  def call
    notification = Rpush::Gcm::Notification.new
    notification.app = Rpush::Gcm::App.find_by_name(APP_NAME)

    notification.registration_ids = registration_ids
    notification.data = { message: message }
    notification.save!
  end
end
