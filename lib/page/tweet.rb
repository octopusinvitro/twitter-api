# frozen_string_literal: true

require_relative '../constants'
require_relative '../response_parser'
require_relative '../secure_client'

module Page
  class Tweet
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_NAME = 'Somebody'
    DEFAULT_TEXT = 'Something...'

    def initialize(params = {}, credentials = {})
      @params = params
      @credentials = credentials
    end

    def title
      'Tweet'
    end

    def status
      tweet[:message] || DEFAULT_STATUS
    end

    def name
      tweet.dig(:contents, :user, :name) || DEFAULT_NAME
    end

    def text
      tweet.dig(:contents, :text) || DEFAULT_TEXT
    end

    def url
      "#{TWITTER_URL}#{tweet.dig(:contents, :user, :screen_name)}"
    end

    private

    attr_reader :params, :credentials

    def tweet
      query = { 'id' => params['id'] }
      response = SecureClient.new(TWEETS_URL, query, credentials).get
      ResponseParser.new(response).parsed_response
    end
  end
end
