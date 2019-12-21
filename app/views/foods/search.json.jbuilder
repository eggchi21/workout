json.array! @foods do |food|
  json.id food.id
  json.name food.name
  json.protein food.protein
  json.fat food.fat
  json.carbo food.carbo
  json.unit food.unit
  json.gram food.gram
  json.image_url food.image_url
  json.kcal food.kcal
end
