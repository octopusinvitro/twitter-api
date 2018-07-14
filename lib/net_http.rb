# frozen_string_literal: true

class NetHttp
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def secure
    client.use_ssl     = true
    client.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def start
    client.start
  end

  def request(request)
    client.request(request)
  end
end
