# frozen_string_literal: true

require 'oauth'

require_relative 'constants'

class SecureClient
  def initialize(credentials = {})
    secure
    @credentials = credentials
  end

  def secure?
    client.use_ssl? && client.verify_mode == 1 && client.port == 443
  end

  def start
    client.start
  end

  def started?
    client.started?
  end

  def authorize
    request.oauth!(client, consumer_key, access_token)
  end

  def response
    client.request(request)
  end

  private

  attr_reader :credentials

  def secure
    client.use_ssl = true
    client.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def consumer_key
    OAuth::Consumer.new(credentials[:api_key], credentials[:api_secret])
  end

  def access_token
    OAuth::Token.new(credentials[:access_token], credentials[:access_secret])
  end

  def client
    @client ||= Net::HTTP.new(VERIFY_URL.host, VERIFY_URL.port)
  end

  def request
    @request ||= Net::HTTP::Get.new(VERIFY_URL.request_uri)
  end
end
