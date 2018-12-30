# frozen_string_literal: true

RSpec.describe SecureClient do
  let(:secure_client) { described_class.new }

  describe 'when setting up' do
    it 'sets up client to use SSL, which is required by Twitter' do
      expect(secure_client.secure?).to be(true)
    end

    it 'starts the client' do
      secure_client.start
      expect(secure_client.started?).to be(true)
    end
  end

  describe 'when sending requests' do
    let(:secure_client_get) do
      NetHttpGet.new(Net::HTTP::Get.new(VERIFY_URL.request_uri))
    end

    it 'calls a request on the client' do
      stub(status: 200, body: '{"screen_name": "Jane"}', headers: {})
      response = secure_client.request(secure_client_get.request)
      expect(response.code).to eq('200')
    end

    it 'receives an error' do
      stub(status: 404, body: '', headers: {})
      response = secure_client.request(secure_client_get.request)
      expect(response.code).to eq('404')
    end
  end
end
