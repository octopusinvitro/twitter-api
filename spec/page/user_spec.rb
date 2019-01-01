# frozen_string_literal: true

require 'page/user'

RSpec.describe Page::User do
  let(:user) do
    stub_request(:get, "#{USERS_URL}?screen_name=twitterdev")
      .to_return(status: 200, body: File.read('spec/fixtures/user.json'))

    described_class.new('screen_name' => 'twitterdev')
  end

  it 'has a title' do
    expect(user.title).not_to be_nil
  end

  it 'has a status' do
    expect(user.status).to eq('Success!')
  end

  it 'has a name' do
    expect(user.name).to eq('Twitter Dev')
  end

  it 'has a link to Twitter profile' do
    expect(user.url).to eq('https://twitter.com/TwitterDev')
  end

  it 'has a location' do
    expect(user.location).to eq('Internet')
  end

  it 'has a description' do
    expect(user.description).to include('Twitter Platform')
  end

  it 'has a followers count' do
    expect(user.followers_count).to eq(503_264)
  end

  it 'has a friends count' do
    expect(user.friends_count).to eq(1476)
  end

  it 'has a favourites count' do
    expect(user.favourites_count).to eq(2183)
  end

  it 'has a statuses count' do
    expect(user.statuses_count).to eq(3368)
  end

  xdescribe 'when user data is malformed' do
    let(:user) do
      stub_request(:get, "#{USERS_URL}?screen_name")
        .to_return(status: 200, body: '')

      described_class.new('screen_name' => '')
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

    it 'has a location anyway' do
      expect(described_class.new.location)
        .to eq(described_class::DEFAULT_LOCATION)
    end
  end
end
