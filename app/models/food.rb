class Food < ApplicationRecord
  has_ancestry
  has_many :diaryfoods ,dependent: :destroy
  has_many :diaries, through: :diaryfoods
  def self.initial_sort(foods)
    foods.inject([]){|result,n| result << n.name[0] unless result.include?(n.name[0]);result}.sort
  end
end
