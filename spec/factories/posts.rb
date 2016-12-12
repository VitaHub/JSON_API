FactoryGirl.define do
  factory :post do
    user
    title "Title"
    body "Some interesting story"
    address
    rating 0
  end
end
