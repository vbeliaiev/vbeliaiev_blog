FactoryBot.define do
  factory :comment do
    body { FFaker::Lorem.phrase }
    user
    post
  end
end
