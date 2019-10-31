class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :address
  accepts_nested_attributes_for :address
  has_many :reports

  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 6, maximum: 128},on: :create
  validates :password_confirmation,   presence: true, confirmation: true, on: :create

  enum sex: {
    man: 0,
    woman: 1
  }
  enum activity: {
    exercise0: 0,
    exercise1to2: 1,
    exercise2to3: 2,
    exercise3to4: 3,
    exercise7: 4
  }
end
