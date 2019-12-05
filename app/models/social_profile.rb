class SocialProfile < ApplicationRecord
  belongs_to :user
  validates :uid,
    presence: true,
    uniqueness: { message: "はすでに存在しています" }
  validates :provider,
    presence: true
  validates :user_id,
    presence: true
end
