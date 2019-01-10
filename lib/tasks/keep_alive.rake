namespace :keep_alive do
  include Rails.application.routes.url_helpers

  desc "Pings the web worker"
  task perform: :environment do
    Net::HTTP.get(URI.parse(static_hosting_ping_url))
  end
end
