# frozen_string_literal: true

require 'page/tweet'

RSpec.describe Page::Tweet do
  let(:tweet) do
    stub_request(:get, "#{TWEETS_URL}?id=1079497619074940929")
      .to_return(status: 200, body: File.read('spec/fixtures/tweet.json'))

    described_class.new('id' => '1079497619074940929')
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

  xdescribe 'when tweet data is malformed' do
    let(:tweet) do
      stub_request(:get, "#{TWEETS_URL}?id")
        .to_return(status: 200, body: '')

      described_class.new('id' => '')
    end

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
