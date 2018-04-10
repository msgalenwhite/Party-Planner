require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'
require "sinatra/activerecord"

set :bind, '0.0.0.0'  # bind to all interfaces

# def form_complete(array)
#   array.each do |item|
#     if item == ""
#       return false
#     end
#   end
#   return true
# end

get '/' do
  redirect '/parties'
end

get '/parties/new' do

  erb :'parties/new_party'
end

get '/parties/:id' do
  id = params[:id]

  @party = Party.find(id)

  erb :'parties/single_party'
end

get '/parties' do
  @parties = Party.all

  erb :'parties/index'
end


post '/parties/new' do
  @party_name = params[:name]
  @party_description = params[:description]
  @party_location = params[:location]

  # if !form_complete([@party_name, @party_location, @party_description])
  if @party_name == "" ||
    @party_description == "" ||
    @party_location == ""

    erb :'/parties/new_party'
  else

    Party.create(
      name: @party_name,
      location: @party_location,
      description: @party_description
    )

    id = Party.last.id

    redirect "/parties/#{id}"
  end
end
