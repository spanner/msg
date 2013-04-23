# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bounce, :class => 'Msg::Bounce' do
    factory :valid_bounce do
      association :envelope, factory: :valid_envelope
      email "test@spanner.org"
    end
  end
end
