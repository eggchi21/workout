class Address < ApplicationRecord
  belongs_to :user, optional: true

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  validates :postcode,                presence: true
  validates :prefecture_code,         presence: true
  validates :city,                    presence: true
  validates :address1,                 presence: true
end
