require 'spec_helper'

describe MyService::Client do
  describe '#create_foobar' do
    before do
      expect(Foobar.count).to eq 0
      @name = Faker::Lorem.word
      @result = MyService::Client.create_foobar(name: @name)
    end
    it 'creates a foobar' do
      expect(Foobar.count).to eq 1
    end
    it 'returns a result consistent with what we expect' do
      expect(@result).to be_a Hash
      expect(@result[:name]).to eq @name
    end
  end
end
