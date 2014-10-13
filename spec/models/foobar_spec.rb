require 'spec_helper'

describe Foobar do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:foobar)).to be_valid
  end
end
