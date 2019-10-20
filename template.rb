# frozen_string_literal: true

BASE_PATH = '/home/harukaedu/Codes/ruby/rails-app-template'

# methods definitions
def actives_support_rspec
  gsub_file('rails_helper.rb',
            "# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }",
            "Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }")
end

def add_factory_bot_include_configuration
  gsub_file('rails_helper.rb',
            'RSpec.configure do |config|',
            "RSpec.configure do |config|\n  config.include FactoryBot::Syntax::Methods")
end

def add_web_drivers
  path = "#{BASE_PATH}/assets/chromedriver"
  run 'mkdir web_drivers'
  run "cp #{path} web_drivers/chromedriver"
end

def add_capybara_support
  path = "#{BASE_PATH}/code/capybara.rb"
  run 'mkdir support'
  run "cp #{path} support/capybara.rb"
end

def add_rubocop
  path = "#{BASE_PATH}/code/.rubocop.yml"
  run "cp #{path} .rubocop.yml"
end

def add_forms
  run 'mkdir forms'
  run 'cd forms && touch .keep'
end

def add_services
  run 'mkdir services'
  run 'cd services && touch .keep'
end

def add_policies
  run 'mkdir policies'
  run 'cd policies && touch .keep'
end

def add_presenters
  run 'mkdir presenters'
  run 'cd presenters && touch .keep'
end

def add_serializers
  run 'mkdir serializers'
  run 'cd serializers && touch .keep'
end

def add_values
  run 'mkdir values'
  run 'cd values && touch .keep'
end

def initials_commit
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end

def upgrade_yarn
  run 'yarn upgrade'
end

def install_vue
  run 'bundle exec rails webpacker:install:vue'
end

def add_bootstrap
  run 'yarn add bootstrap jquery popper.js'
end

def add_application_scss
  file = File.open('application.scss', 'w')
  file.puts "@import '~bootstrap/scss/bootstrap';"
end

def add_bootstrap_importer
  gsub_file('application.js',
            '// const imagePath = (name) => images(name, true)',
            "// const imagePath = (name) => images(name, true)\nimport 'bootstrap'\nimport './src/application.scss'")
end

# main program
gem 'pry-rails'
gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
end
gem_group :developement do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

after_bundle do
  run 'spring stop'
  generate 'rspec:install'
  inside('spec') do
    actives_support_rspec
    add_web_drivers
    add_capybara_support
    add_factory_bot_include_configuration
  end
  add_rubocop
  inside('app') do
    add_forms
    add_services
    add_policies
    add_presenters
    add_serializers
    add_values
  end
  upgrade_yarn
  install_vue
  add_bootstrap
  inside('app/javascript/packs/src') do
    add_application_scss
  end
  inside('app/javascript/packs/') do
    add_bootstrap_importer
  end
  initials_commit
end
