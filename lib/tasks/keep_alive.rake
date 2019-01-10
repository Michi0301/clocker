namespace :keep_alive do
  include Rails.application.routes.url_helpers

  desc "Pings the web worker and the client application"
  task perform: :environment do
    Net::HTTP.get(URI.parse(static_hosting_ping_url))
    Net::HTTP.get(URI.parse(Rails.application.config.x.client_url))
  end
end
