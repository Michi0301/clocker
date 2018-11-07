require 'capybara'
require 'capybara/poltergeist'
# require 'selenium/webdriver'

# Configure Poltergeist to not blow up on websites with js errors aka every website with js
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# Capybara.register_driver :chrome do |app|
# end

# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  #     chromeOptions: { args: %w(headless disable-gpu) }
  #   )

  #   Capybara::Selenium::Driver.new app,
  #     browser: :chrome,
  #     desired_capabilities: capabilities
  # end

# Capybara.default_driver = :chrome
Capybara.default_driver = :poltergeist

Capybara.default_max_wait_time = 10
