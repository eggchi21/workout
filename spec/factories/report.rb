FactoryBot.define do
  factory :report do
    weight              { 72.5 }
    entry_on            { "2019/11/18" }
    text                { "こんにちは" }
    user
  end
end
