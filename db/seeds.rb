# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed GCM app idempotently
if auth_key = ENV['PUSH_AUTH_KEY']
  app = Rpush::Gcm::App.find_or_create_by name: SendNotification::APP_NAME

  app.auth_key = auth_key
  app.connections = 1
  app.save!
end
