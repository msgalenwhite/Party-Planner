require "./server"
require "sinatra/activerecord/rake"
require "rspec/core/rake_task"

# begin
#   RSpec::Core::RakeTask.new(:spec)
# rescue LoadError
#   puts "Please 'bundle', first."
# end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

task default: [Rake::Task["db:test:prepare"], :spec]

# I added this, don't know if I need it
# came from "https://learn.launchacademy.com/teams/boston-20/curricula/on-campus-boston-20/lesson_groups/week_5:_databases/lessons/activerecord-migrations"

# namespace :db do
#   task :load_config do
#     require "./server"
#   end
# end
