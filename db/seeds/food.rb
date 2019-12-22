require 'csv'
CSV.foreach('db/food.csv', headers: true) do |record|
  Food.create(
    name: record[0],
    protein: record[1],
    fat: record[2],
    carbo: record[3],
    unit: record[4],
    gram: record[5],
    image_url: record[6],
    ancestry: record[7],
    kcal: record[8]
  )
end
