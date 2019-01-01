# frozen_string_literal: true

require_relative '../constants'
require_relative '../response_parser'
require_relative '../secure_client'

module Page
  class User
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_NAME = 'Unknown name'
    DEFAULT_LOCATION = 'Unknown location'

    def initialize(params = {}, credentials = {})
      @params = params
      @credentials = credentials
    end

    def title
      'Hello'
    end

    def status
      user[:message] || DEFAULT_STATUS
    end

    def name
      user.dig(:contents, :name) || DEFAULT_NAME
    end

    def url
      "#{TWITTER_URL}#{user.dig(:contents, :screen_name)}"
    end

    def location
      user.dig(:contents, :location) || DEFAULT_LOCATION
    end

    def description
      user.dig(:contents, :description)
    end

    def followers_count
      user.dig(:contents, :followers_count)
    end

    def friends_count
      user.dig(:contents, :friends_count)
    end

    def favourites_count
      user.dig(:contents, :favourites_count)
    end

    def statuses_count
      user.dig(:contents, :statuses_count)
    end

    private

    attr_reader :params, :credentials

    def user
      query = URI.encode_www_form('screen_name' => params['screen_name'])
      url = "#{USERS_URL}?#{query}"

      response = SecureClient.new(url, credentials).get
      ResponseParser.new(response).parsed_response
    end
  end
end
