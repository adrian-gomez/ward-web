FactoryGirl.define do
  factory :instance do
    sequence(:ip) { |n| "127.0.0.#{n}" }
    label         'Example Instance'
  end
end