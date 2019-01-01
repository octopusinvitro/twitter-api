# frozen_string_literal: true

require 'page/post'

RSpec.describe Page::Post do
  let(:post) do
    stub_request(:post, POST_URL)
      .with(body: 'status=alohomora')
      .to_return(status: 200, body: File.read('spec/fixtures/post.json'))

    described_class.new('status' => 'alohomora')
  end

  it 'has a title' do
    expect(post.title).not_to be_nil
  end

  it 'has a status' do
    expect(post.status).to eq('Success!')
  end

  it 'has a text' do
    expect(post.text).to include('Something...')
  end

  xdescribe 'when post data is malformed' do
    let(:post) do
      stub_request(:post, POST_URL)
        .with(body: 'status')
        .to_return(status: 200, body: File.read('spec/fixtures/post.json'))

      described_class.new('status' => '')
    end

    it 'has a status anyway' do
      expect(described_class.new.status).to eq(described_class::DEFAULT_STATUS)
    end

    it 'has a link anyway' do
      expect(described_class.new.url).to eq(TWITTER_URL)
    end
  end
end
