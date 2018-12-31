# frozen_string_literal: true

# http://asquera.de/blog/2015-03-30/testing-external-apis-in-ruby/
class Connect
  def initialize(secure_client)
    @secure_client = secure_client
  end

  # The verify credentials endpoint returns a 200 status if
  # the request is signed correctly.
  def verify_credentials(consumer_key, access_token)
    secure_client.oauth(consumer_key, access_token)
    secure_client.start
    secure_client.response
  end

  private

  attr_reader :secure_client
end
