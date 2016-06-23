describe "Parser" do
  let(:parser)       {Parser.new}
  let(:net_http)     {NetHttp.new(Net::HTTP.new(VERIFY_URL.host, VERIFY_URL.port))}
  let(:net_http_get) {NetHttpGet.new(Net::HTTP::Get.new(VERIFY_URL.request_uri))}
  let(:response)     {net_http.request(net_http_get.request)}

  describe "when response is successful" do
    before do
      stub({status: 200, body: '{"screen_name": "Jane"}', headers: {}})
    end

    it "parses body" do
      expect_to_eq(:contents, {screen_name: "Jane"})
    end

    it "sends a welcome message" do
      expect_to_eq(:message, Messages.success("Jane"))
    end
  end

  describe "when response is not successful" do
    before do
      stub({status: 404, body: '{}', headers: {}})
    end

    it "doesn't parse body" do
      expect_to_eq(:contents, {})
    end

    it "sends an error message" do
      expect_to_eq(:message, Messages.failure("404"))
    end
  end

  def expect_to_eq(field, value)
    expect(parser.parse_user(response)[field]).to eq(value)
  end
end
