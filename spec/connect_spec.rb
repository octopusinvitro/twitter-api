# frozen_string_literal: true

describe 'Connect' do
  let(:net_http)     { double(NetHttp) }
  let(:net_http_get) { double(NetHttpGet) }
  let(:connect)      { Connect.new(net_http, net_http_get) }
  let(:consumer_key) { OAuth::Consumer.new('12345', '12345') }
  let(:access_token) { OAuth::Consumer.new('12345', '12345') }

  describe 'when verifying credentials,' do
    before(:each) do
      allow(net_http).to receive(:secure)
      allow(net_http).to receive(:client)
      allow(net_http).to receive(:start)
      allow(net_http).to receive(:request)
      allow(net_http_get).to receive(:oauth)
      allow(net_http_get).to receive(:request)
    end

    it 'sets a secure connection' do
      connect.verify_credentials(consumer_key, access_token)
      expect(net_http).to have_received(:secure).once
    end

    it 'OAuths the request' do
      connect.verify_credentials(consumer_key, access_token)
      expect(net_http_get).to have_received(:oauth).once
      expect(net_http_get).to have_received(:oauth).with(
        net_http.client, consumer_key, access_token
      )
    end

    it 'makes a request with the right request object' do
      connect.verify_credentials(consumer_key, access_token)
      expect(net_http).to have_received(:start).once
      expect(net_http).to have_received(:request).once.with(
        net_http_get.request
      )
    end

    it 'returns 200 if request is signed' do
      resp = Net::HTTPResponse.new(1.1, '200', '')
      allow(net_http).to receive(:request).and_return(resp)
      response = connect.verify_credentials(consumer_key, access_token)
      expect(response.code).to eq('200')
    end

    it 'returns error if request is not signed' do
      resp = Net::HTTPResponse.new(1.1, '404', '')
      allow(net_http).to receive(:request).and_return(resp)
      response = connect.verify_credentials(consumer_key, access_token)
      expect(response.code).to eq('404')
    end
  end

  # it 'queries a twitter user data' do
  #   uri = URI(
  #     'https://api.github.com/repos/thoughtbot/factory_girl/contributors'
  #   )
  #   response = connect.fetch(uri)
  #   expect(response).to be_an_instance_of(String)
  #   expect(response).to eq('stubbed response')
  # end
end
