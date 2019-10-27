class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  def ols
    # xs = [50,60,70,80,90]
    # ys = [40,70,90,60,100]


    xs = [1,2,3,4,5]
    ys = [2,4,6,8,10]
    arry = xs.zip(ys)

    a = arry.convariance/xs.variance #回帰直線の傾き(a = XとYの共分散 / Xの分散)
    b = ys.average - a * xs.average #回帰直線の切片(b = Yの平均 - 回帰直線の傾き * Xの平均)
    {a:a,b:b}
  end

end


class Array
  def average #平均
    sum.to_f / size
  end

  def variance #分散
    inject(0) { |result,n| result + (n - average) ** 2 } / size
  end

  def unbiasedvariance #不偏分散
    inject(0) { |result,n| result + (n - average) ** 2 } / (size - 1)
  end

  def stadiv #標準偏差
    Math.sqrt(variance)
  end

  def convariance #共分散
    ary1 = map{|xs| xs[0]}
    ary2 = map{|ys| ys[1]}
    inject(0) { |result,n| result + (n[0] - ary1.average) * (n[1] - ary2.average)}/ size
  end
end
