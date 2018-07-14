# frozen_string_literal: true

describe 'Messages' do
  it 'prints welcome message with a name' do
    expect(Messages.success('Jane')).to include('Jane')
  end

  it 'prints an error message with a code' do
    expect(Messages.failure('404')).to include('404')
  end
end
