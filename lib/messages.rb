# frozen_string_literal: true

module Messages
  def self.success
    'Success!'
  end

  def self.failure(code)
    "Sorry, expected a response of 200 but got #{code} instead"
  end
end
