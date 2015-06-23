require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    context "email format" do
      context "is valid" do
        it do
          should allow_value('a+b@bar.name', 'A_F-OO@b.a.org', 'foo@bar.COM',
            'fst.lst@bar.ua', 'example@from.aero').for(:email)
        end
      end

      context "is invalid" do
        it { should_not allow_value('example.user@foo.').for(:email) }
        it { should_not allow_value('foo@bar+baz.com').for(:email) }
        it { should_not allow_value('foo@bar_baz.com').for(:email) }
        it { should_not allow_value('user@foo,com').for(:email) }
        it { should_not allow_value('user_at_foo.org').for(:email) }
      end
    end
  end

  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:ratings).dependent(:destroy) }
  end

  describe '#current_order' do
    let(:user) { create(:user_with_orders) }

    it 'doesn\'t return list of all orders' do
      expect(user.current_order).to_not match_array(user.orders)
    end

    it 'returns current order in progress' do
      expect(user.current_order).to eq user.orders.first
    end
  end
end
