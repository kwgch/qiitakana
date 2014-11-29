FactoryGirl.define do  factory :stock do
    user nil
post nil
  end

  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobarbuzz"
    password_confirmation "foobarbuzz"
  end
end
