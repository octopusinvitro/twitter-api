# frozen_string_literal: true

require 'messages'

RSpec.describe Messages do
  it 'prints welcome message with a name' do
    expect(described_class.success('Jane')).to include('Jane')
  end

  it 'prints an error message with a code' do
    expect(described_class.failure('404')).to include('404')
  end
end
