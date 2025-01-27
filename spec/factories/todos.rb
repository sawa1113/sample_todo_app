FactoryBot.define do
  factory :todo do
    title { "固定タイトル" }
    description { "固定説明文" }
    completed { false }
    attachment { nil }
    user
  end
end