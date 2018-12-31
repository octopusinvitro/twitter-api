# frozen_string_literal: true

require 'main'

RSpec.describe Main do
  let(:app) { described_class.new }

  it 'renders the index page' do
    stub(status: 200, body: '{"screen_name": "Jane"}')
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Hello')
  end

  it 'renders the error page if there is an error' do
    get '/unknown_path'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include('Page Not Found')
  end

  it 'loads the reset stylesheet' do
    get '/stylesheets/main.css'
    expect(last_response).to be_ok
    expect(last_response.body).to include('normalize')
  end
end
