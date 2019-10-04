# frozen_string_literal: true

# TODO:
# 1. Add rspec gems
# 2. Install rspec
# 3. Copy chrome drivers
# 4. Setup system spec configurations in spec_helper

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

after_bundle do
  generate 'rspec:install'
  run 'mkdir spec/web_drivers'
  current_chrome_driver_path = '/home/harukaedu/Codes/ruby/rails-template/chromedriver'
  inside('spec') do
    run "cp #{current_chrome_driver_path} web_driver/chromedriver"
  end
end

git :init
git add: '.'
git commit: "-a -m 'Initial commit'"
