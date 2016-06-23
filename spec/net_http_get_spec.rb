describe "NetHttpGet" do

  let(:request)      {Net::HTTP::Get.new(VERIFY_URL.request_uri)}
  let(:net_http_get) {NetHttpGet.new(request)}

  it "authorizes a request with OAuth" do
    client       = Net::HTTP.new(VERIFY_URL.host, VERIFY_URL.port)
    consumer_key = OAuth::Consumer.new("12345", "67890")
    access_token = OAuth::Token.new("12345", "67890")

    result = net_http_get.oauth(client, consumer_key, access_token)

    expect_key_to_eq(result, "oauth_consumer_key", "12345")
    expect_key_to_eq(result, "oauth_token", "12345")
    expect_key_to_eq(result, "oauth_signature_method", "HMAC-SHA1")
  end

  def hashify(string)
    no_first_word = string.split(' ')[1..-1].join(' ')
    no_quotes     = no_first_word.gsub '"', ''
    final         = no_quotes.split(", ").map { |pair| pair.split("=") }
    final.to_h
  end

  def expect_key_to_eq(result, key, value)
    expect(hashify(result)[key]).to eq(value)
  end

end

# OAuth::Consumer.new(ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"],
# OAuth::Token.new(ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_SECRET"]
