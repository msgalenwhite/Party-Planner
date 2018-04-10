require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  redirect '/parties'
end

get '/parties' do
  erb :'parties/index'
end
