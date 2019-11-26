FactoryBot.define do

  factory :user do
    nickname              {"サンプル1"}
    email                 {"sample1@gmail.com"}
    password              {"000000"}
    password_confirmation {"000000"}

    factory :another_user do
      nickname              {"サンプル2"}
      email                 {"sample2@gmail.com"}
      password              {"000000"}
      password_confirmation {"000000"}
    end
  end
end