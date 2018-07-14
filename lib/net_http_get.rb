# frozen_string_literal: true

class NetHttpGet
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def oauth(client, consumer_key, access_token)
    request.oauth!(client, consumer_key, access_token)
  end
end
