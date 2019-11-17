class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaryfoods ,dependent: :destroy
  accepts_nested_attributes_for :diaryfoods, allow_destroy: true

  validates :entry_on,presence:true, uniqueness: true
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}

  def date_cannot_be_in_the_future
    if entry_on.present? && entry_on > Date.today
      errors.add(:entry_on, ": 今日以降の日付は登録できません")
    end
  end
end
