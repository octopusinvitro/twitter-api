# frozen_string_literal: true

require 'sinatra'

require_relative 'constants'
require_relative 'response_parser'
require_relative 'secure_client'

class Main < Sinatra::Base
  set :views, "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"
  set :credentials,
      api_key: ENV['API_KEY'],
      api_secret: ENV['API_SECRET'],
      access_token: ENV['ACCESS_TOKEN'],
      access_secret: ENV['ACCESS_SECRET']

  get '/' do
    @title = 'Hello'
    erb :index
  end

  get '/user' do
    query = URI.encode_www_form('screen_name' => params['screen_name'])
    url = "#{USERS_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).verify_credentials
    user = ResponseParser.new(response).parsed_response
    @title = 'Hello'
    @contents = user[:contents][:name]
    @message = user[:message]
    erb :index
  end

  get '/tweet' do
    query = URI.encode_www_form('id' => params['id'])
    url = "#{TWEETS_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).verify_credentials
    tweet = ResponseParser.new(response).parsed_response
    @title = 'Tweet'
    @contents = tweet[:contents][:user][:name] + ' - ' + tweet[:contents][:text]
    @message = tweet[:message]
    erb :index
  end

  get '/timeline' do
    query = URI.encode_www_form(
      'screen_name' => params['screen_name'],
      'count' => 10
    )
    url = "#{TIMELINE_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).verify_credentials
    tweets = ResponseParser.new(response).parsed_response
    @title = 'Timeline'
    @contents = tweets[:contents].map { |tweet| tweet[:text] }
    @message = tweets[:message]
    erb :index
  end

  not_found do
    status 404
    @title = 'Page Not Found'
    erb :oops
  end
end
