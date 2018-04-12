ENV["RACK_ENV"] ||= "test"
require "rspec"
require "capybara/rspec"
require "capybara/poltergeist"

#I added these from another project:
require_relative 'support/database_cleaner'
require_relative '../server.rb'

require 'valid_attribute'
require 'shoulda'

set :environment, :test

# this was provided
require_relative '../server.rb'
Dir[__dir__ + '/support/*.rb'].each { |file| require_relative file }

Capybara.app = Sinatra::Application
# Capybara./challenge/party-planner = Sinatra::Application

# Capybara.javascript_driver = :poltergeist

# this is also from a different project where rspec worked
RSpec.configure do |config|
  config.backtrace_exclusion_patterns << /.rubies/
  config.backtrace_exclusion_patterns << /.gem/

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed
end
