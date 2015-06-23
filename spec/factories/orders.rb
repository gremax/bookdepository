FactoryGirl.define do
  factory :order do
    total_price "9.99"
    state "in progress"
    user
    completed_at "2015-06-17 21:08:20"

    trait :random_state do
      state { %w(in\ progress completed shipped).sample }
    end

    trait :one_user do
      user
    end

    factory :order_with_random_state, traits: [:random_state, :one_user]
  end
end
