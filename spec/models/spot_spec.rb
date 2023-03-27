require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'validations' do
    let(:spot) { FactoryBot.build(:spot) } 
    
    it 'is valid with valid attributes' do
      expect(spot).to be_valid
    end
    
    it 'is not valid without a title' do
      spot.title = nil
      expect(spot).to_not be_valid
    end
    
    it 'is not valid without a description' do
      spot.description = nil
      expect(spot).to_not be_valid
    end
    
    it 'is not valid without a price' do
      spot.price = nil
      expect(spot).to_not be_valid
    end
    
    it 'is not valid with a non-numeric price' do
      spot.price = 'abc'
      expect(spot).to_not be_valid
    end
  end
  
  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
  end
  
  describe 'serialization' do
    it { should serialize(:image_url).as(Array) }
  end
end
