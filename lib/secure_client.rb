# frozen_string_literal: true

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

  def request(request)
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
end
