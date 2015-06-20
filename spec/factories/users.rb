FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end

  factory :invalid_user, class: 'User' do
    email nil
    password nil
  end
end
