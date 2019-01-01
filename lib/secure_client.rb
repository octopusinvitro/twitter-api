# frozen_string_literal: true

require 'oauth'

require_relative 'constants'

class SecureClient
  def initialize(url, query = nil, credentials = {})
    @url = url
    @query = query
    @credentials = credentials
  end

  def get
    secure
    authorize
    response
  end

  def secure?
    client.use_ssl? && client.verify_mode == 1 && client.port == 443
  end

  private

  attr_reader :url, :query, :credentials

  def secure
    client.use_ssl = true
    client.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def authorize
    consumer_key = OAuth::Consumer.new(
      credentials[:api_key], credentials[:api_secret]
    )
    access_token = OAuth::Token.new(
      credentials[:access_token], credentials[:access_secret]
    )
    request.oauth!(client, consumer_key, access_token)
  end

  def response
    client.start { |http| http.request(request) }
  end

  def client
    @client ||= Net::HTTP.new(uri.host, uri.port)
  end

  def request
    @request ||= Net::HTTP::Get.new(uri)
  end

  def uri
    return URI(url.to_s) unless query

    @uri ||= URI("#{url}?#{URI.encode_www_form(query)}")
  end
end
