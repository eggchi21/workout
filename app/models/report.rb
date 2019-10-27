class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  def self.ols(reports)
    ys = reports.map(&:weight)
    xs = date_to_axis(reports.map(&:entry_on))

    array = xs.zip(ys)
    a = array.convariance / xs.variance # 回帰直線の傾き(a = XとYの共分散 / Xの分散)
    b = ys.average - a * xs.average # 回帰直線の切片(b = Yの平均 - 回帰直線の傾き * Xの平均)
    # {a:a,b:b}

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

end


class Array
  def average # 平均
    sum.to_f / size
  end

  def variance # 分散
    inject(0) { |result,n| result + (n - average) ** 2 } / size
  end

  def unbiasedvariance # 不偏分散
    inject(0) { |result,n| result + (n - average) ** 2 } / (size - 1)
  end

  def stadiv # 標準偏差
    Math.sqrt(variance)
  end

  def convariance # 共分散
    array1 = map{|xs| xs[0]}
    array2 = map{|ys| ys[1]}
    inject(0) { |result,n| result + (n[0] - array1.average) * (n[1] - array2.average)}/ size
  end
end
