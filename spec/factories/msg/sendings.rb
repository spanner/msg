# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sending, :class => 'Msg::Sending' do
    message
  end
end
