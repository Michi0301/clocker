Capybara.register_driver(:headless_chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.configure do |config|
  config.run_server = true
  config.default_driver = :headless_chrome
  config.default_max_wait_time = 30
end

Capybara.javascript_driver = :headless_chrome
