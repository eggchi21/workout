class Plan < ApplicationRecord
  belongs_to :user
  enum method: {
    lowfat: 0,
    lowcarbo: 1
  }
end
