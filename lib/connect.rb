# frozen_string_literal: true

class Connect
  def initialize(secure_client)
    @secure_client = secure_client
  end

  def verify_credentials
    secure_client.verify_credentials
  end

  private

  attr_reader :secure_client
end
