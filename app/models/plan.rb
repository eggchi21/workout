class Plan < ApplicationRecord
  belongs_to :user

  validates :start_weight,presence:true
  validates :target_weight,presence:true
  validates :start_on,presence:true
  validates :target_on,presence:true
  validates :method,presence:true
  validates :protein,presence:true
  validates :fat,presence:true
  validates :carbo,presence:true
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}


  enum method: {
    lowfat: 0,
    lowcarbo: 1
  }
end
