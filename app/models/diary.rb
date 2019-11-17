class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaryfoods ,dependent: :destroy
  accepts_nested_attributes_for :diaryfoods, allow_destroy: true

  validates :entry_on, uniqueness: true, date: true
  validate :date_cannot_be_in_the_future
  validate :calendar_valid?
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}

  def date_cannot_be_in_the_future
    if entry_on.present? && entry_on > Date.today
      errors.add(:entry_on, "は今日以降を登録できません")
    end
  end

  def calendar_valid?
    date = entry_on_before_type_cast
    return if date.blank?
    y = date[0, 4].to_i
    m = date[6, 2].to_i
    d = date[9, 2].to_i
    unless Date.valid_date?(y, m, d)
      errors.add(:date, "カレンダーにない日付です")
    end
  end
end
