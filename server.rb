require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'
require "sinatra/activerecord"
require "faker"

set :bind, '0.0.0.0'  # bind to all interfaces

# GET ROUTES

### PARTY GET ROUTES

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
  @invited_friends = @party.friends

  @remaining_friends = Friend.all.reject { |friend| @invited_friends.include?(friend) }
  @message = params[:message]

  erb :'parties/single_party'
end

get '/parties' do
  @parties = Party.all

  erb :'parties/index'
end

### FRIEND GET ROUTES

get '/friends' do

  @friends = Friend.all

  erb :'friends/index'
end

get '/friends/new' do
  @errors = []
  erb :'friends/new_friend'
end

get '/friends/:message' do
  @message = params[:message]
  @friends = Friend.all

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

post '/parties/:id' do
  party_id = params[:id]
  new_friend_id = params[:new_invite]

  InvitedFriend.create(party_id: party_id, friend_id: new_friend_id)

  redirect "/parties/#{party_id}"
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
