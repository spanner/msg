# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :envelope, :class => 'Msg::Envelope' do
    factroy :valid_envelope do
      association :receiver, factory: :user
      sending
    end
  end
end
