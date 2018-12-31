# frozen_string_literal: true

RSpec.describe Connect do
  let(:secure_client) { double(SecureClient) }
  let(:connect) { described_class.new(secure_client) }
  let(:consumer_key) { OAuth::Consumer.new('12345', '12345') }
  let(:access_token) { OAuth::Consumer.new('12345', '12345') }

  describe 'when verifying credentials,' do
    before(:each) do
      allow(secure_client).to receive(:start)
      allow(secure_client).to receive(:response)
      allow(secure_client).to receive(:oauth)
    end

    it 'OAuths the request' do
      connect.verify_credentials(consumer_key, access_token)
      expect(secure_client)
        .to have_received(:oauth).once.with(consumer_key, access_token)
    end

    it 'makes a secure request' do
      connect.verify_credentials(consumer_key, access_token)
      expect(secure_client).to have_received(:start).once
      expect(secure_client).to have_received(:response).once
    end

    it 'returns 200 if request is signed' do
      response = Net::HTTPResponse.new(1.1, '200', '')
      allow(secure_client).to receive(:response).and_return(response)
      verified = connect.verify_credentials(consumer_key, access_token)
      expect(verified.code).to eq('200')
    end

    it 'returns error if request is not signed' do
      response = Net::HTTPResponse.new(1.1, '404', '')
      allow(secure_client).to receive(:response).and_return(response)
      verified = connect.verify_credentials(consumer_key, access_token)
      expect(verified.code).to eq('404')
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
