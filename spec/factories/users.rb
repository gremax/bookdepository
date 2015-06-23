FactoryGirl.define do
  factory :user do
    email     { Faker::Internet.email }
    password  '12345678'
    password_confirmation '12345678'
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    is_admin  false

    factory :admin do
      is_admin true
    end

    factory :user_with_orders do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:order, evaluator.posts_count, user: user)
      end
    end
  end

  factory :invalid_user, class: 'User' do
    email    nil
    password nil
  end
end
