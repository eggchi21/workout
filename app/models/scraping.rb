class Scraping
  def self.food_urls
    agent = Mechanize.new
    top_page = agent.get("https://calorie.slism.jp")
    categories = top_page.search('.menuContents ul li ul li a')
    categories.each do |category|
      get_category(category)
    end
  end

  def self.get_category(category)
    name = category.inner_text
    link = category.get_attribute('href')
    category = Food.where(name: name).first_or_initialize
    category.save
    get_food_link(category, link)
  end

  def self.get_food_link(category, link)
    next_url = ""
    @category = category
    @link = link
    agent = Mechanize.new
    loop do
      category_page = if next_url == ""
                        agent.get('https://calorie.slism.jp' + link)
                      else
                        agent.get('https://calorie.slism.jp' + next_url)
                      end
      foods = category_page.search('.ccdsCatList li a')
      foods.each do |food|
        food_link = food.get_attribute('href')
        get_food_page(@category, 'https://calorie.slism.jp' + food_link)
      end
      links = category_page.search('#pager a')
      @next_link = ""
      links.each do |link|
        @next_link = link if link.inner_text == '＞'
      end
      break if @next_link == ""

      next_url = @next_link.get_attribute('href')
    end
  end

  def self.get_food_page(category, link)
    @category = category
    @link = link
    agent = Mechanize.new
    food_page = agent.get(link)
    name = food_page.at('.ccdsSingleHl01').inner_text.gsub(/[\r\n]/, "")
    protein = food_page.at('#protein_content').inner_text.to_f
    fat = food_page.at('#fat_content').inner_text.to_f
    carbo = food_page.at('#carb_content').inner_text.to_f
    kcal = food_page.at('.singlelistKcal').inner_text.to_i
    unit = if food_page.at('#serving_comment')
             food_page.at('#serving_comment').inner_text
           else
             'No Data'
           end
    gram = food_page.at('#serving_content').inner_text.to_f
    image_url = 'https:' + food_page.at('#foodImage')[:src]
    if food = Food.find_by(name: name)
      food.update(
        name: name,
        protein: protein,
        fat: fat,
        carbo: carbo,
        kcal: kcal,
        unit: unit,
        gram: gram,
        image_url: image_url
      )
    else
      food = @category.children.create(
        name: name,
        protein: protein,
        fat: fat,
        carbo: carbo,
        kcal: kcal,
        unit: unit,
        gram: gram,
        image_url: image_url
      )
    end
  end
end
