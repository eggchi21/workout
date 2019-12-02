FactoryBot.define do

  factory :food do
    name               {"プロテイン"}
    protein            {20}
    fat                {1}
    carbo              {5}
    unit               {"1杯"}
    gram               {50.0}
    image_url          {"https://cdn.slism.jp/calorie/foodImages/101011.jpg"}
    ancestry           {1}
    kcal               {109}
  end

end