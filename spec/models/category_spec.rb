require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  describe 'association' do
    it { should have_many(:books).dependent(:destroy) }
  end

  describe '#to_s' do
    let(:category) { create(:category) }

    it 'returns category title' do
      expect(category.to_s).to eq category.title
    end
  end
end
