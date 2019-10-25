# frozen_string_literal: true

RSpec.configure do |config|
  chrome = Selenium::WebDriver::Chrome::Service
  chrome.driver_path = Rails.root.join('spec', 'web_drivers', 'chromedriver').to_path

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1050]
  end
end
