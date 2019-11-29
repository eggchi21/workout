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
  validate :start_on_target_on_calendar_valid?
  validates :method, inclusion: {in: Plan.methods.keys}
  validates :protein, presence:true,numericality: { only_integer: true, greater_than: 0 }
  validates :fat, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :carbo, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}

  def start_on_target_on_calendar_valid?
    start_on = start_on_before_type_cast
    target_on = target_on_before_type_cast

    return if start_on.blank? || target_on.blank?
    ys = start_on[0, 4].to_i
    ms = start_on[5, 2].to_i
    ds = start_on[8, 2].to_i

    yt = start_on[0, 4].to_i
    mt = start_on[5, 2].to_i
    dt = start_on[8, 2].to_i

    unless Date.valid_date?(ys, ms, ds)
      errors.add(:start_on, start_on + "はカレンダーにない日付です")
    end

    unless Date.valid_date?(yt, mt, dt)
      errors.add(:target_on, target_on + "はカレンダーにない日付です")
    end
  end

end
