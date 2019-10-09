# frozen_string_literal: true

RSpec.configure do |config|
  Selenium::WebDriver::Chrome.driver_path = "#{::Rails.root}/spec/web_drivers/chromedriver"

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1050]
  end
end
