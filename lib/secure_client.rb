# frozen_string_literal: true

require 'constants'

class SecureClient
  def initialize
    secure
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

  def oauth(consumer_key, access_token)
    request.oauth!(client, consumer_key, access_token)
  end

  def response
    client.request(request)
  end

  private

  def secure
    client.use_ssl = true
    client.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def client
    @client ||= Net::HTTP.new(VERIFY_URL.host, VERIFY_URL.port)
  end

  def request
    @request ||= Net::HTTP::Get.new(VERIFY_URL.request_uri)
  end
end
