class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaryfoods ,dependent: :destroy
  has_many :foods, through: :diaryfoods
  accepts_nested_attributes_for :diaryfoods, allow_destroy: true

  validates :entry_on, uniqueness: { scope: :user_id }, date: true
  validate :date_cannot_be_in_the_future
  validate :calendar_valid?
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}
  validate :require_any_diaryfoods

  def date_cannot_be_in_the_future
    if entry_on.present? && entry_on > Date.today
      errors.add(:entry_on, "は今日以降を登録できません")
    end
  end

  def calendar_valid?
    date = entry_on_before_type_cast
    return if date.blank?
    y = date[0, 4].to_i
    m = date[5, 2].to_i
    d = date[8, 2].to_i
    unless Date.valid_date?(y, m, d)
      errors.add(:date, "カレンダーにない日付です")
    end
  end

  def require_any_diaryfoods
    errors.add(:diaryfood, "は最低1つ記録してください") if diaryfoods.blank?
  end

  def self.calc_kcal(diaries)
    @kcals = []
    diaries.each do |diary|
      kcals = diary.foods.map(&:kcal)
      amounts = diary.diaryfoods.map(&:amount)
      @kcals << kcals.zip(amounts).map{|kcal,amount| kcal * amount}.sum
    end
    return @kcals
  end
end
