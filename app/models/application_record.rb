class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  module ArrayStatistics
    refine Array do
      # 平均
      def average
        sum.fdiv(size)
      end

      # 分散
      def variance
        @average = average
        inject(0) { |result, n| result + (n - @average)**2 }.fdiv(size)
      end

      # 不偏分散
      def unbiasedvariance
        @average = average
        inject(0) { |result, n| result + (n - @average)**2 }.fdiv(size - 1)
      end

      # 標準偏差
      def stadiv
        Math.sqrt(variance)
      end

      # 共分散
      def convariance
        array1 = map { |xs| xs[0] }
        array2 = map { |ys| ys[1] }
        @average1 = array1.average
        @average2 = array2.average
        inject(0) { |result, n| result + (n[0] - @average1) * (n[1] - @average2) }.fdiv(size)
      end
    end
  end
end
