# frozen_string_literal: true

require_relative '../constants'

module Page
  class Timeline
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_NAME = 'Somebody'

    def initialize(tweets = {})
      @tweets = tweets
    end

    def title
      'Timeline'
    end

    def status
      tweets[:message] || DEFAULT_STATUS
    end

    def name
      tweets[:contents]&.first&.dig(:user, :name) || DEFAULT_NAME
    end

    def url
      "#{TWITTER_URL}#{tweets[:contents]&.first&.dig(:user, :screen_name)}"
    end

    def list
      tweets[:contents].map { |tweets| tweets[:text] }
    end

    private

    attr_reader :tweets
  end
end
