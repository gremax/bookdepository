FactoryGirl.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    biography { Faker::Lorem.paragraph }
  end

  factory :invalid_author, class: 'Author' do
    firstname nil
    lastname nil
    biography nil
  end
end
