require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'
require "sinatra/activerecord"

#PROBLEM - how to get a "success!" method when a party is created?

set :bind, '0.0.0.0'  # bind to all interfaces

# GET ROUTES
get '/' do
  redirect '/parties'
end

get '/parties/new' do

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
  erb :'friends/new_friend'
end

get '/friends/:message' do
  @message = params[:message]
  @friends = Friend.order(first_name: :asc)

  erb :'friends/index'
end

# POST ROUTES
post '/parties/new' do
  @party_name = params[:name]
  @party_description = params[:description]
  @party_location = params[:location]

  if @party_name == "" ||
    @party_description == "" ||
    @party_location == ""

    @message = "Please fill the form completely."
    erb :'/parties/new_party'
  else

    Party.create(
      name: @party_name,
      location: @party_location,
      description: @party_description
    )

    id = Party.last.id

    message = "Your party has been created!"

    redirect "/parties/#{id}/#{message}"
  end
end

post '/friends/new' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]

  if @first_name == "" ||
    @last_name == ""

    @message = "Please fill the form completely."
    erb :'/friends/new_friend'
  else

    Friend.create(
      first_name: @first_name,
      last_name: @last_name
    )

    id = Friend.last.id

    @message = "Your friend has been added to the list!"

    redirect "/friends/#{@message}"
  end
end
