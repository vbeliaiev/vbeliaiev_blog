FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.phrase }
    body { FFaker::Lorem.paragraph(10) }
    user

    trait :with_tag_body do
      body { "#{FFaker::Lorem.paragraph(10)}##{rand(10_000)} dsafd" }
    end
  end
end
