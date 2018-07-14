# frozen_string_literal: true

# http://asquera.de/blog/2015-03-30/testing-external-apis-in-ruby/
class Connect
  def initialize(net_http, net_http_get)
    @net_http     = net_http
    @net_http_get = net_http_get
  end

  # The verify credentials endpoint returns a 200 status if
  # the request is signed correctly.
  def verify_credentials(consumer_key, access_token)
    net_http.secure
    net_http_get.oauth(net_http.client, consumer_key, access_token)
    net_http.start
    net_http.request(net_http_get.request)
  end

  private

  attr_reader :net_http, :net_http_get
end
