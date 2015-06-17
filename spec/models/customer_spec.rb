require 'rails_helper'

RSpec.describe Customer, type: :model do
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

  it { should have_many(:orders) }
  it { should have_many(:ratings) }
end
