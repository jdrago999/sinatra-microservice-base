require 'spec_helper'

describe MyService::Client do
  describe '#create_user' do
    before do
      expect(User.count).to eq 0
    end
    it 'creates a user' do
      MyService::Client.create_user(email: 'foo@bar.com')
      expect(User.count).to eq 1
    end
  end
end
