FactoryBot.define do

  factory :diary do
    entry_on                {"2019/11/18"}
    evaluation              {"not_yet"}
    user
    after(:create) do |diary|
      create(:diaryfood , diary_id: diary.id)
    end
  end

end