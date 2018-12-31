# frozen_string_literal: true

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

  describe 'when authorizing' do
    let(:secure_client) do
      credentials = {
        api_key: '12345',
        api_secret: '67890',
        access_token: '12345',
        access_secret: '67890'
      }
      described_class.new(credentials)
    end

    it 'sets the consumer key' do
      expect(secure_client.authorize).to include('oauth_consumer_key="12345"')
    end

    it 'sets the access token' do
      expect(secure_client.authorize).to include('oauth_token="12345"')
    end

    it 'sets the signature method' do
      expect(secure_client.authorize).to include('signature_method="HMAC-SHA1"')
    end

    it 'has no consumer key if no credentials passed' do
      expect(described_class.new.authorize).not_to include('oauth_consumer_key')
    end

    it 'has no access token if no credentials passed' do
      expect(described_class.new.authorize).not_to include('oauth_token')
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
