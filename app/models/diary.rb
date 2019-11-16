class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaryfoods ,dependent: :destroy
  accepts_nested_attributes_for :diaryfoods, allow_destroy: true
end
