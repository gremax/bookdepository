require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end

  describe 'association' do
    it { should have_many(:books).dependent(:destroy) }
  end

  describe '#full_name' do
    let(:author) { create(:author) }

    it 'returns string with author' do
      expect(author.full_name).to eq "#{author.firstname} #{author.lastname}"
    end
  end
end
