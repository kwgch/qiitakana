# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    references ""
    first_name "MyString"
    last_name "MyString"
    website_url "MyString"
    location "MyString"
    description "MyText"
    facebook_id "MyString"
    linkedin_id "MyString"
    google_plus_id "MyString"
  end
end
