# frozen_string_literal: true

require 'main'

RSpec.describe Main do
  def app
    described_class.new
  end

  it 'renders the index page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Hello')
  end

  it 'renders the error page if there is an error' do
    get '/unknown_path'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include('Page Not Found')
  end
end
