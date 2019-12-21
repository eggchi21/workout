class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  module ArrayStatistics
    refine Array do
      def average # 平均
        sum.fdiv(size)
      end

      def variance # 分散
        @average = average
        inject(0) { |result, n| result + (n - @average)**2 }.fdiv(size)
      end

      def unbiasedvariance # 不偏分散
        @average = average
        inject(0) { |result, n| result + (n - @average)**2 }.fdiv(size - 1)
      end

      def stadiv # 標準偏差
        Math.sqrt(variance)
      end

      def convariance # 共分散
        array1 = map { |xs| xs[0] }
        array2 = map { |ys| ys[1] }
        @average1 = array1.average
        @average2 = array2.average

        inject(0) { |result, n| result + (n[0] - @average1) * (n[1] - @average2) }.fdiv(size)
      end
    end
  end
end
