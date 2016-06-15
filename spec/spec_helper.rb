ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'simplecov-rcov'

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.start 'rails' do
  add_filter '/lib/tasks/'
end

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'authlogic/test_case'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = true
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each, database_integrity: true do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    ActionMailer::Base.deliveries.clear
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.include Authlogic::TestCase

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

