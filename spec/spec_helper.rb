ENV["RACK_ENV"] ||= "test"
require "rspec"
require "capybara/rspec"
require "capybara/poltergeist"

require_relative '../server.rb'
Dir[__dir__ + '/support/*.rb'].each { |file| require_relative file }

Capybara./challenge/party-planner = Sinatra::Application
Capybara.javascript_driver = :poltergeist
