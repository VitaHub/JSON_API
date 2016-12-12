FactoryGirl.define do
  factory :address do
    sequence(:ip) { |n| "192.168.1.#{n}" }
  end
end
