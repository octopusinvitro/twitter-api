# frozen_string_literal: true

# https://developer.github.com/webhooks/securing/
class Main < Sinatra::Base
  set :views, "#{settings.root}/../views"

  get '/' do
    @title = 'Hello'
    erb :index
  end

  not_found do
    status 404
    @title = 'Page Not Found'
    erb :oops
  end
end
