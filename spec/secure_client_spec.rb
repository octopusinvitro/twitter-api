# frozen_string_literal: true

require 'oauth'
require 'secure_client'

RSpec.describe SecureClient do
  let(:secure_client) { described_class.new }

  describe 'when setting up' do
    it 'sets up client to use SSL, which is required by Twitter' do
      expect(secure_client.secure?).to be(true)
    end

    it 'can starts the client' do
      secure_client.start
      expect(secure_client.started?).to be(true)
    end
  end

  describe 'when setting oauth' do
    let(:result) do
      consumer_key = OAuth::Consumer.new('12345', '67890')
      access_token = OAuth::Token.new('12345', '67890')

      secure_client.oauth(consumer_key, access_token)
    end

    it 'authorizes sets the consumer key' do
      expect(result).to include('oauth_consumer_key="12345"')
    end

    it 'authorizes sets the token' do
      expect(result).to include('oauth_token="12345"')
    end

    it 'authorizes sets the signature method' do
      expect(result).to include('oauth_signature_method="HMAC-SHA1"')
    end
  end

  describe 'when sending requests' do
    it 'calls a request on the client' do
      stub(status: 200, body: '{"screen_name": "Jane"}', headers: {})
      response = secure_client.response
      expect(response.code).to eq('200')
    end

    it 'receives an error' do
      stub(status: 404, body: '', headers: {})
      response = secure_client.response
      expect(response.code).to eq('404')
    end
  end
end
