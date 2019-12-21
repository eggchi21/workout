(1..5).each do |n|
  gimei = Gimei.new
  address = Gimei.address
  User.create!(email: "sample#{n}@sample.com",
               password: "password",
               password_confirmation: "password",
               nickname: "サンプル#{n}",
               introduction: "")
  Address.create!(user_id: n,
                  postcode: 111,
                  prefecture_code: n,
                  city: address.city.kanji,
                  address1: address.town.kanji,
                  address2: "#{n}丁目#{n}-#{n}")
end

(6..10).each do |n|
  gimei = Gimei.new
  address = Gimei.address
  @user = User.create!(email: "sample#{n}@sample.com",
                       password: "password",
                       password_confirmation: "password",
                       nickname: "サンプル#{n}",
                       introduction: "#{n}番目のユーザー",
                       sex: 0,
                       age: rand(18..60),
                       height: rand(140..180),
                       activity: 2)
  Address.create!(user_id: n,
                  postcode: 111,
                  prefecture_code: n,
                  city: address.city.kanji,
                  address1: address.town.kanji,
                  address2: "#{n}丁目#{n}-#{n}")
  Plan.create!(user_id: n,
               start_weight: 70.0 + rand(1.1..10.0).round(1),
               target_weight: 70.0 - rand(1.1..10.0).round(1),
               start_on: Faker::Date.between(from: 60.days.ago, to: Date.today).strftime('%Y/%m/%d'),
               target_on: Faker::Date.forward(days: 23).strftime('%Y/%m/%d'),
               method: n % 2,
               protein: 120 + n,
               fat: 50 + n,
               carbo: 250 + n)
end
