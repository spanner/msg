# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message, :class => 'Msg::Message' do
    from_name "bill"
    from_address "bill@example.com"
    subject "title"
    body "lorem ipsum"
  end
end
