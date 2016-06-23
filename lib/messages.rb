module Messages

  def self.success(name)
    "Hello, #{name}!"
  end

  def self.failure(code)
    "Sorry, expected a response of 200 but got #{code} instead"
  end

end
