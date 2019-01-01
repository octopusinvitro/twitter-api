# frozen_string_literal: true

require_relative '../constants'

module Page
  class Tweet
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_NAME = 'Somebody'
    DEFAULT_TEXT = 'Something...'

    def initialize(tweet = {})
      @tweet = tweet
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

    attr_reader :tweet
  end
end
