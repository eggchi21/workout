FactoryBot.define do
  factory :food do
    name               { Faker::Food.dish }
    protein            { 20 }
    fat                { 1 }
    carbo              { 5 }
    unit               { "1杯" }
    gram               { 50.0 }
    image_url          { "https://cdn.slism.jp/calorie/foodImages/101011.jpg" }
    ancestry           { 1 }
    kcal               { 109 }
    factory :food_ancestry_is_nil do
      name               { Faker::Food.dish }
      protein            { nil }
      fat                { nil }
      carbo              { nil }
      unit               { nil }
      gram               { nil }
      image_url          { nil }
      ancestry           { nil }
      kcal               { nil }
    end
  end
end
