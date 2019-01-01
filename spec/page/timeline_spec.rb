# frozen_string_literal: true

require 'page/timeline'

RSpec.describe Page::Timeline do
  let(:timeline) do
    stub_request(:get, "#{TIMELINE_URL}?screen_name=twitterapi&count=10")
      .to_return(status: 200, body: File.read('spec/fixtures/timeline.json'))

    described_class.new('screen_name' => 'twitterapi')
  end

  it 'has a title' do
    expect(timeline.title).not_to be_nil
  end

  it 'has a status' do
    expect(timeline.status).to eq('Success!')
  end

  it 'has a name' do
    expect(timeline.name).to eq('Twitter API')
  end

  it 'has a link to tweeter' do
    expect(timeline.url).to eq('https://twitter.com/TwitterAPI')
  end

  it 'has a list of tweets' do
    expect(timeline.list.first).to include('app management')
  end

  xdescribe 'when timeline data is malformed' do
    let(:timeline) do
      stub_request(:get, "#{TIMELINE_URL}?screen_name=&count=10")
        .to_return(status: 200, body: '')

      described_class.new('screen_name' => 'twitterapi')
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
