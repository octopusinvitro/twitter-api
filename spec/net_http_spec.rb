# frozen_string_literal: true

describe 'NetHttp' do
  let(:client)   { Net::HTTP.new(VERIFY_URL.host, VERIFY_URL.port) }
  let(:net_http) { NetHttp.new(client) }

  describe 'when setting up' do
    it 'sets up Net::HTTP to use SSL, which is required by Twitter' do
      net_http.secure
      expect(client.use_ssl?).to be(true)
      expect(client.verify_mode).to eq(1)
      expect(client.port).to eq(443)
    end

    it 'starts the client' do
      net_http.start
      expect(client.started?).to be(true)
    end
  end

  describe 'when sending requests' do
    let(:net_http_get) do
      NetHttpGet.new(Net::HTTP::Get.new(VERIFY_URL.request_uri))
    end

    it 'calls a request on the client' do
      stub(status: 200, body: '{"screen_name": "Jane"}', headers: {})
      response = net_http.request(net_http_get.request)
      expect(response.code).to eq('200')
    end

    it 'receives an error' do
      stub(status: 404, body: '', headers: {})
      response = net_http.request(net_http_get.request)
      expect(response.code).to eq('404')
    end
  end
end
