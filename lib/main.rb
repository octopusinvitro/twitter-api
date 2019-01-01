# frozen_string_literal: true

require 'sinatra'

require_relative 'page/index'
require_relative 'page/not_found'
require_relative 'page/post'
require_relative 'page/timeline'
require_relative 'page/tweet'
require_relative 'page/user'

class Main < Sinatra::Base
  set :views, "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"
  set :credentials,
      api_key: ENV['API_KEY'],
      api_secret: ENV['API_SECRET'],
      access_token: ENV['ACCESS_TOKEN'],
      access_secret: ENV['ACCESS_SECRET']

  get '/' do
    @page = Page::Index.new
    erb :index
  end

  get '/user' do
    @page = Page::User.new(params, settings.credentials)
    erb :user
  end

  get '/tweet' do
    @page = Page::Tweet.new(params, settings.credentials)
    erb :tweet
  end

  get '/timeline' do
    @page = Page::Timeline.new(params, settings.credentials)
    erb :timeline
  end

  get '/post' do
    @page = Page::Post.new(params, settings.credentials)
    erb :post
  end

  not_found do
    status 404
    @page = Page::NotFound.new
    erb :oops
  end
end
