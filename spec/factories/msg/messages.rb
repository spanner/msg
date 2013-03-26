# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message, :class => 'Msg::Message' do
    body "lorem ipsum"
  end
end
