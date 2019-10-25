(1..5).each do |n|
  gimei = Gimei.new
  address = Gimei.address
  User.create!(email:"sample#{n}@sample.com",
                password:"password",
                password_confirmation:"password",
                nickname:gimei.last.kanji + gimei.first.kanji,
                introduction:"",)
  Address.create!(user_id:n,
                  postcode:111,
                  prefecture_code:n,
                  city:address.city.kanji,
                  address1:address.town.kanji,
                  address2:"#{n}丁目#{n}-#{n}",)
end