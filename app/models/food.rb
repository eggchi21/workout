class Food < ApplicationRecord
  has_ancestry
  has_many :diaryfoods, dependent: :destroy
  has_many :diaries, through: :diaryfoods
  has_one_attached :image

  validates :name, presence: true
  with_options if: :ancestry_is_not_nil? do
    validates :protein, presence: true
    validates :fat, presence: true
    validates :carbo, presence: true
    validates :unit, presence: true
    validates :gram, presence: true
    validates :kcal, presence: true
  end

  with_options if: :ancestry_is_nil? do
    validates :protein, absence: true
    validates :fat, absence: true
    validates :carbo, absence: true
    validates :unit, absence: true
    validates :gram, absence: true
    validates :kcal, absence: true
  end

  def ancestry_is_not_nil?
    ancestry != nil
  end

  def ancestry_is_nil?
    ancestry.nil?
  end

  def self.initial_sort(foods)
    foods.each_with_object([]) { |n, result| result << n.name[0] unless result.include?(n.name[0]); }.sort
  end
end
