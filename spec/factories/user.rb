FactoryBot.define do
  factory :user do
    nickname { "サンプル1" }
    sequence(:email) { Faker::Internet.email }
    password              { "000000" }
    password_confirmation { "000000" }

    factory :another_user do
      nickname              { "サンプル2" }
      email                 { "sample2@gmail.com" }
      password              { "000000" }
      password_confirmation { "000000" }
    end

    factory :updated_user do
      nickname              { "サンプル2" }
      email                 { "sample2@gmail.com" }
      password              { "000000" }
      password_confirmation { "000000" }
      introduction          { "こんにちは" }
      sex                   { "man" }
      age                   { 27 }
      height                { 170 }
      activity              { "exercise3to4" }
    end
  end
end
