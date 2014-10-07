require 'spec_helper'

describe 'Foo' do
  describe 'POST /users' do
    before do
      expect(User.count).to eq 0
    end
    it 'creates a user' do
      ApiClient::Wrapper.create_user(email: 'foo@bar.com')
    end
  end
end
