# frozen_string_literal: true

require 'page/tweet'

RSpec.describe Page::Tweet do
  let(:tweet) do
    tweet_fixture = File.read('spec/fixtures/tweet.json')
    tweet_data = {
      contents: JSON.parse(tweet_fixture, symbolize_names: true),
      message: 'Success!'
    }
    described_class.new(tweet_data)
  end

  it 'has a title' do
    expect(tweet.title).not_to be_nil
  end

  it 'has a status' do
    expect(tweet.status).to eq('Success!')
  end

  it 'has a name' do
    expect(tweet.name).to eq('Twitter')
  end

  it 'has a text' do
    expect(tweet.text).to include('#HappyNewYear')
  end

  it 'has a link to tweeter' do
    expect(tweet.url).to eq('https://twitter.com/Twitter')
  end

  describe 'when tweet data is malformed' do
    it 'has a status anyway' do
      expect(described_class.new.status).to eq(described_class::DEFAULT_STATUS)
    end

    it 'has a name anyway' do
      expect(described_class.new.name).to eq(described_class::DEFAULT_NAME)
    end

    it 'has a link anyway' do
      expect(described_class.new.url).to eq(TWITTER_URL)
    end
  end
end
