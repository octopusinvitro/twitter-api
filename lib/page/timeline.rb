# frozen_string_literal: true

require_relative '../constants'
require_relative '../response_parser'
require_relative '../secure_client'

module Page
  class Timeline
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_NAME = 'Somebody'

    def initialize(params = {}, credentials = {})
      @params = params
      @credentials = credentials
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

    attr_reader :params, :credentials

    def tweets
      query = {
        'screen_name' => params['screen_name'],
        'count' => 10
      }
      response = SecureClient.new(TIMELINE_URL, query, credentials).get
      ResponseParser.new(response).parsed_response
    end
  end
end
