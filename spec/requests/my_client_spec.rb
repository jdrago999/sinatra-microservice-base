require 'spec_helper'

describe MyService::Client do
  describe '#create_user' do
    before do
      expect(User.count).to eq 0
      @email = Faker::Internet.email
      @result = MyService::Client.create_user(email: @email)
    end
    it 'creates a user' do
      expect(User.count).to eq 1
    end
    it 'returns a result consistent with what we expect' do
      expect(@result).to be_a Hash
      expect(@result[:email]).to eq @email
    end
  end
end
