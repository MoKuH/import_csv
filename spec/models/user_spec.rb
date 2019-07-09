require 'rails_helper'

RSpec.describe User, type: :model do
  describe "valid object" do
    user = User.new(name: 'test',date: Date.today,number: 1, description: "test description")

    it 'object must be valid' do
      expect( user.valid?).to be(true)
    end
    it 'error code should be 0' do
      expect(user.errors.size).to eq(0)
    end
  end

  describe "not valid object with values" do
    user = User.new(name: 'test',date: "2019,08,12",number: "1", description: "test description")

    it 'object must be invalid' do
      expect(user.valid?).to_not be(true)
    end
    it 'error code should be 2' do
      expect(user.errors.size).to eq(2)
    end
  end

  describe "not valid object without value" do
    user = User.new
    it 'object must be invalid' do
      expect(user.valid?).to_not be(true)
    end
    it 'error code should be 6' do
      expect(user.errors.size).to eq(6)
    end
  end
end


