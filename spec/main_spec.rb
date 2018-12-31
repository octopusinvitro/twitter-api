# frozen_string_literal: true

require 'main'

RSpec.describe Main do
  let(:app) { described_class.new }

  it 'renders the error page if there is an error' do
    get '/unknown_path'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include('Page Not Found')
  end

  it 'loads the styles' do
    get '/stylesheets/main.css'
    expect(last_response).to be_ok
    expect(last_response.body).to include('normalize')
  end

  it 'renders the index page' do
    stub_request(:get, VERIFY_URL)
      .to_return(status: 200, body: '{"screen_name": "Jane"}')

    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Hello')
  end

  it 'renders a user' do
    stub_request(:get, "#{USERS_URL}?screen_name=twitterdev")
      .to_return(status: 200, body: File.read('spec/fixtures/user.json'))

    get '/user', 'screen_name' => 'twitterdev'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Twitter Dev')
  end

  it 'renders a tweet' do
    stub_request(:get, "#{TWEETS_URL}?id=1079497619074940929")
      .to_return(status: 200, body: File.read('spec/fixtures/tweet.json'))

    get '/tweet', 'id' => '1079497619074940929'
    expect(last_response).to be_ok
    expect(last_response.body).to include('#HappyNewYear')
  end

  it 'renders a timeline' do
    stub_request(:get, "#{TIMELINE_URL}?screen_name=twitterapi&count=10")
      .to_return(status: 200, body: File.read('spec/fixtures/timeline.json'))

    get '/timeline', 'screen_name' => 'twitterapi'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Twitter APIs')
  end
end
