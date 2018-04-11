require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'
require "sinatra/activerecord"
require "faker"

#PROBLEM - how to get a "success!" method when a party is created?

set :bind, '0.0.0.0'  # bind to all interfaces

# GET ROUTES
get '/' do
  redirect '/parties'
end

get '/parties/new' do
  @errors = []
  erb :'parties/new_party'
end

get '/parties/:id/:message' do
  id = params[:id]

  @party = Party.find(id)
  @message = params[:message]

  erb :'parties/single_party'
end

get '/parties/:id' do
  id = params[:id]

  @party = Party.find(id)
  @message = params[:message]

  erb :'parties/single_party'
end

get '/parties' do
  @parties = Party.all

  erb :'parties/index'
end

get '/friends' do

  @friends = Friend.order(first_name: :asc)

  erb :'friends/index'
end

get '/friends/new' do
  @errors = []
  erb :'friends/new_friend'
end

get '/friends/:message' do
  @message = params[:message]
  @friends = Friend.order(first_name: :asc)

  erb :'friends/index'
end

# POST ROUTES
post '/parties/new' do

# #validate on the model, so we can use 'new' each time, and save will only work if it passes the validation (so this becomes our conditonal)

  @party_name = params[:name]
  @party_description = params[:description]
  @party_location = params[:location]

  new_party = Party.new(name: @party_name, location: @party_location, description: @party_description)

  if new_party.save

    id = Party.last.id
    message = "Your party has been created!"

# #flash messages would be way better
    redirect "/parties/#{id}/#{message}"
  else
    @errors = new_party.errors.full_messages

    erb :'/parties/new_party'
  end
end

post '/friends/new' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]

  new_friend = Friend.new(first_name: @first_name, last_name: @last_name)

  if (new_friend.save)

    id = Friend.last.id

    @message = "Your friend has been added to the list!"
    redirect "/friends/#{@message}"
  else
    # THIS RETURNS AN ARRAY
    @errors = new_friend.errors.full_messages
    erb :'/friends/new_friend'
  end
end
