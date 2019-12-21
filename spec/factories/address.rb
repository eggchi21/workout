FactoryBot.define do
  factory :address do
    postcode                   { 2_530_045 }
    prefecture_code            { "神奈川県" }
    city                       { "茅ヶ崎市" }
    address1                   { "十間坂3丁目*番号" }
    address2                   { "ムキムキ荘202号室" }
    user
  end
end
