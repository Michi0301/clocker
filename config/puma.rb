# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 1)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  # Do not embed in rails console

  ActiveSupport.on_load(:after_initialize) do
    Rpush.embed
  end
end
