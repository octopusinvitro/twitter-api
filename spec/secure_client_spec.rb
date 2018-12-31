# frozen_string_literal: true

require 'secure_client'
require 'constants'

RSpec.describe SecureClient do
  let(:secure_client) do
    credentials = {
      api_key: '12345', api_secret: '67890',
      access_token: '12345', access_secret: '67890'
    }
    described_class.new(VERIFY_URL, credentials)
  end

  it 'sets up client to use SSL, which is required by Twitter' do
    stub(status: 200, body: '{"screen_name": "Jane"}')
    secure_client.verify_credentials
    expect(secure_client.secure?).to be(true)
  end

  describe 'when authorized' do
    it 'sets the consumer key' do
      headers = { headers: { 'Authorization' => /oauth_consumer_key="12345"/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.verify_credentials
    end

    it 'sets the access token' do
      headers = { headers: { 'Authorization' => /oauth_token="12345"/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.verify_credentials
    end

    it 'sets the signature method' do
      headers = { headers: {
        'Authorization' => /signature_method="HMAC-SHA1"/
      } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.verify_credentials
    end

    it 'returns an OK response' do
      stub(status: 200, body: '{"screen_name": "Jane"}')
      response = secure_client.verify_credentials
      expect(response.code).to eq('200')
    end
  end

  describe 'when not authorized' do
    let(:secure_client) { described_class.new(VERIFY_URL) }

    it 'has no consumer key' do
      headers = { headers: { 'Authorization' => /(?!oauth_consumer_key)/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.verify_credentials
    end

    it 'has no access token' do
      headers = { headers: { 'Authorization' => /(?!oauth_token)/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.verify_credentials
    end

    it 'returns a bad request error' do
      stub(status: 400, body: '', headers: {})
      response = secure_client.verify_credentials
      expect(response.code).to eq('400')
    end
  end
end
