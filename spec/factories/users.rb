# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "bob"
    email "bob@example.com"
    factory :admin do
      admin true
    end
  end
end
