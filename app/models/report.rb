module ArrayStatistics
  refine Array do
    def average # 平均
      sum.fdiv(size)
    end

    def variance # 分散
      @average = average
      inject(0) { |result,n| result + (n - @average) ** 2 }.fdiv(size)
    end

    def unbiasedvariance # 不偏分散
      @average = average
      inject(0) { |result,n| result + (n - @average) ** 2 }.fdiv(size - 1)
    end

    def stadiv # 標準偏差
      Math.sqrt(variance)
    end

    def convariance # 共分散
      array1 = map{|xs| xs[0]}
      array2 = map{|ys| ys[1]}
      @average1 = array1.average
      @average2 = array2.average

      inject(0) { |result,n| result + (n[0] - @average1) * (n[1] -@average2)}.fdiv(size)
    end
  end
end

class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  using ArrayStatistics

  validates :weight,presence:true
  validates :entry_on,presence:true, uniqueness: true, date: true
  validate :date_cannot_be_in_the_future
  validate :calendar_valid?
  validates :user_id, presence: true
  validates :user, presence: true,if: -> {user_id.present?}

  def date_cannot_be_in_the_future
    if entry_on.present? && entry_on > Date.today
      errors.add(:entry_on, ": 今日以降の日付は登録できません")
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


  def self.ols(reports)
    ys = reports.map(&:weight)
    xs = date_to_axis(reports.map(&:entry_on))

    array = xs.zip(ys)
    a = array.convariance.fdiv(xs.variance) # 回帰直線の傾き(a = XとYの共分散 / Xの分散)
    b = ys.average - a * xs.average # 回帰直線の切片(b = Yの平均 - 回帰直線の傾き * Xの平均)

    week_after = (a * (xs.last + 7) + b).round(1)

  end

  def self.date_to_axis(array)
    axis =[]
    before_elem = nil
    array.each.with_index(1) do | elem , i |
      if i == 1
        @axis_elem = 1
      else
        @axis_elem = @axis_elem + (elem - before_elem).numerator
      end
      before_elem = elem
      axis << @axis_elem
    end
    return axis
  end

  scope :entry_on_between, -> from, to {
    if from.present? && to.present?
      where(entry_on: from..to).order(entry_on: 'ASC')
    elsif from.present?
      where('entry_on >= ?', from).order(entry_on: 'ASC')
    elsif to.present?
      where('entry_on <= ?', to).order(entry_on: 'ASC')
    end
  }

end