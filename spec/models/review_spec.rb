require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    let(:review) { FactoryBot.create(:review) }
    
    it 'is valid with valid attributes' do
      expect(review).to be_valid
    end
    
    it 'is not valid without a body' do
      review.body = nil
      expect(review).to_not be_valid
    end
  end
  
  describe 'associations' do
    it { should belong_to(:spot) }
  end
end
