# frozen_string_literal: true

require_relative '../response_parser'
require_relative '../secure_client'

module Page
  class Post
    DEFAULT_STATUS = 'Unknown status'
    DEFAULT_TEXT = 'Something...'

    def initialize(params = {}, credentials = {})
      @params = params
      @credentials = credentials
    end

    def title
      'Posted'
    end

    def status
      post[:message] || DEFAULT_STATUS
    end

    def text
      post.dig(:contents, :status, :text) || DEFAULT_TEXT
    end

    private

    attr_reader :params, :credentials

    def post
      data = { 'status' => params['status'] }
      response = SecureClient.new(POST_URL, nil, credentials).post(data)
      ResponseParser.new(response).parsed_response
    end
  end
end
