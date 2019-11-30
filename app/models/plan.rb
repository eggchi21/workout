class Plan < ApplicationRecord
  belongs_to :user
  enum method: {
    lowfat: 0,
    lowcarbo: 1
  }
  validates :start_weight, presence:true, numericality: {greater_than: 0}
  validates :target_weight, presence:true, numericality: {greater_than: 0}
  validates :start_on, presence:true, date: true
  validates :target_on, presence:true, date: true
  validate :start_on_calendar_valid?
  validate :target_on_calendar_valid?
  validates :method, inclusion: {in: Plan.methods.keys}
  validates :protein, presence:true,numericality: { only_integer: true, greater_than: 0 }
  validates :fat, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :carbo, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}

  def start_on_calendar_valid?
    date = start_on_before_type_cast
    return if date.blank?
    y = date[0, 4].to_i
    m = date[5, 2].to_i
    d = date[8, 2].to_i
    unless Date.valid_date?(y, m, d)
      errors.add(:start_on, date + "はカレンダーにない日付です")
    end
  end

  def target_on_calendar_valid?
    date = target_on_before_type_cast
    return if date.blank?
    y = date[0, 4].to_i
    m = date[5, 2].to_i
    d = date[8, 2].to_i
    unless Date.valid_date?(y, m, d)
      errors.add(:target_on, date + "はカレンダーにない日付です")
    end
  end

end
