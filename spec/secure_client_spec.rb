# frozen_string_literal: true

require 'secure_client'
require 'constants'

RSpec.describe SecureClient do
  let(:secure_client) do
    credentials = {
      api_key: '12345', api_secret: '67890',
      access_token: '12345', access_secret: '67890'
    }
    described_class.new(VERIFY_URL, nil, credentials)
  end
  let(:get_fixture) { File.read('spec/fixtures/verify_credentials.json') }
  let(:post_fixture) { File.read('spec/fixtures/post.json') }

  it 'sets up client to use SSL, which is required by Twitter' do
    stub_request(:get, VERIFY_URL).to_return(status: 200, body: get_fixture)
    secure_client.get
    expect(secure_client.secure?).to be(true)
  end

  it 'accepts query parameters' do
    stub_request(:get, "#{VERIFY_URL}?skip_status=1")
      .to_return(status: 200, body: get_fixture)

    response = described_class.new(VERIFY_URL, 'skip_status' => 1).get
    expect(response.code).to eq('200')
  end

  describe 'when authorized' do
    it 'sets the consumer key' do
      headers = { headers: { 'Authorization' => /oauth_consumer_key="12345"/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.get
    end

    it 'sets the access token' do
      headers = { headers: { 'Authorization' => /oauth_token="12345"/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.get
    end

    it 'sets the signature method' do
      headers = { headers: {
        'Authorization' => /signature_method="HMAC-SHA1"/
      } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.get
    end

    it 'returns an OK response' do
      stub_request(:get, VERIFY_URL).to_return(status: 200, body: get_fixture)
      response = secure_client.get
      expect(response.code).to eq('200')
    end
  end

  describe 'when not authorized' do
    let(:secure_client) { described_class.new(VERIFY_URL) }

    it 'has no consumer key' do
      headers = { headers: { 'Authorization' => /(?!oauth_consumer_key)/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.get
    end

    it 'has no access token' do
      headers = { headers: { 'Authorization' => /(?!oauth_token)/ } }
      stub_request(:get, VERIFY_URL).with(headers)
      secure_client.get
    end

    it 'returns a bad request error' do
      stub_request(:get, VERIFY_URL).to_return(status: 400, body: '')
      response = secure_client.get
      expect(response.code).to eq('400')
    end
  end

  describe '#post' do
    it 'returns an OK response' do
      stub_request(:post, VERIFY_URL).with(body: 'status=yourtweet').to_return(
        status: 200, body: post_fixture
      )

      response = secure_client.post('status' => 'yourtweet')
      expect(response.code).to eq('200')
    end
  end
end
