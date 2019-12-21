FactoryBot.define do
  factory :plan do
    start_weight               { 67 }
    target_weight              { 63 }
    start_on                   { "2019/11/03" }
    target_on                  { "2019/11/30" }
    # method                     { 'lowfat' }
    protein                    { 208 }
    fat                        { 23 }
    carbo                      { 260 }
    user
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end
