class Diaryfood < ApplicationRecord
  belongs_to :diary, optional: true
  belongs_to :food
end
