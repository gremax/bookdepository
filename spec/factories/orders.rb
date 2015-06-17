FactoryGirl.define do
  factory :order do
    total_price "9.99"
    state "in progress"
    customer nil
    completed_at "2015-06-17 21:08:20"
  end
end
