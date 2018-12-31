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
    client = SecureClient.new(VERIFY_URL, settings.credentials)
    user = ResponseParser.new(client.verify_credentials).parsed_response
    @title = 'Hello'
    @contents = user[:contents]
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

  not_found do
    status 404
    @title = 'Page Not Found'
    erb :oops
  end
end
