# frozen_string_literal: true

require 'sinatra'

require_relative 'constants'
require_relative 'page/index'
require_relative 'page/timeline'
require_relative 'page/tweet'
require_relative 'page/user'
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
    @title = Page::Index.new.title
    erb :index
  end

  get '/user' do
    query = URI.encode_www_form('screen_name' => params['screen_name'])
    url = "#{USERS_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).get
    user = ResponseParser.new(response).parsed_response

    @page = Page::User.new(user)
    @title = @page.title
    erb :user
  end

  get '/tweet' do
    query = URI.encode_www_form('id' => params['id'])
    url = "#{TWEETS_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).get
    tweet = ResponseParser.new(response).parsed_response

    @page = Page::Tweet.new(tweet)
    @title = @page.title
    erb :tweet
  end

  get '/timeline' do
    query = URI.encode_www_form(
      'screen_name' => params['screen_name'],
      'count' => 10
    )
    url = "#{TIMELINE_URL}?#{query}"

    response = SecureClient.new(url, settings.credentials).get
    tweets = ResponseParser.new(response).parsed_response

    @page = Page::Timeline.new(tweets)
    @title = @page.title
    erb :timeline
  end

  not_found do
    status 404
    @title = 'Page Not Found'
    erb :oops
  end
end
