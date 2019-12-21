FactoryBot.define do
  factory :diary do
    entry_on                { "2019/11/18" }
    evaluation              { "not_yet" }
    user
    after(:create) do |diary|
      # food = create(:food)
      create(:diaryfood, food: create(:food), diary: diary, amount: 10)
    end
  end
end
