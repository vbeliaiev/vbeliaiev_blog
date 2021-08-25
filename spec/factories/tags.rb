FactoryBot.define do
  factory :tag do
    name { FFaker::Lorem.word + rand(10_000).to_s }
  end
end
