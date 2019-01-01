# frozen_string_literal: true

require 'json'

require_relative 'messages'

class ResponseParser
  def initialize(response)
    @response = response
  end

  def parsed_response
    {
      contents: contents,
      message: message
    }
  end

  private

  attr_reader :response

  def contents
    JSON.parse(response.body, symbolize_names: true)
  end

  def message
    success? ? success_message : failure_message
  end

  def success?
    response.code == '200'
  end

  def success_message
    Messages.success
  end

  def failure_message
    Messages.failure(response.code)
  end
end
