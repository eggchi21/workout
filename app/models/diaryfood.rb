class Diaryfood < ApplicationRecord
  belongs_to :diary, optional: true
  belongs_to :food
  validates :amount ,presence:true, numericality: { greater_than: 0 }

end
