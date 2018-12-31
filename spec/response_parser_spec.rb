# frozen_string_literal: true

require 'response_parser'

RSpec.describe ResponseParser do
  let(:user) { described_class.new(response).parse_user }

  describe 'when response is successful' do
    let(:response) { FakeResponse.new('{"screen_name": "Jane"}', '200') }

    it 'parses body' do
      expect(user[:contents]).to eq(screen_name: 'Jane')
    end

    it 'sends a welcome message' do
      expect(user[:message]).to include('Jane')
    end
  end

  describe 'when response is not successful' do
    let(:response) { FakeResponse.new('{}', '404') }

    it 'does not parse body' do
      expect(user[:contents]).to be_empty
    end

    it 'sends an error message' do
      expect(user[:message]).to include('404')
    end
  end

  FakeResponse = Struct.new(:body, :code)
end
