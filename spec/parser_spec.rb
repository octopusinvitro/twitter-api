# frozen_string_literal: true

RSpec.describe 'Parser' do
  let(:parser) { Parser.new }
  let(:response) { SecureClient.new.verify_credentials }

  describe 'when response is successful' do
    before do
      stub(status: 200, body: '{"screen_name": "Jane"}')
    end

    it 'parses body' do
      expect_to_eq(:contents, screen_name: 'Jane')
    end

    it 'sends a welcome message' do
      expect_to_eq(:message, Messages.success('Jane'))
    end
  end

  describe 'when response is not successful' do
    before do
      stub(status: 404, body: '{}', headers: {})
    end

    it "doesn't parse body" do
      expect_to_eq(:contents, {})
    end

    it 'sends an error message' do
      expect_to_eq(:message, Messages.failure('404'))
    end
  end

  def expect_to_eq(field, value)
    expect(parser.parse_user(response)[field]).to eq(value)
  end
end
