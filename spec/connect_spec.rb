# frozen_string_literal: true

require 'connect'
require 'secure_client'

RSpec.describe Connect do
  let(:secure_client) { double(SecureClient) }
  let(:connect) { described_class.new(secure_client) }

  describe 'when verifying credentials' do
    before do
      allow(secure_client).to receive(:verify_credentials)
    end

    it 'returns 200 if request is signed' do
      response = Net::HTTPResponse.new(1.1, '200', '')
      allow(secure_client).to receive(:verify_credentials).and_return(response)
      verified = connect.verify_credentials
      expect(verified.code).to eq('200')
    end

    it 'returns error if request is not signed' do
      response = Net::HTTPResponse.new(1.1, '404', '')
      allow(secure_client).to receive(:verify_credentials).and_return(response)
      verified = connect.verify_credentials
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
