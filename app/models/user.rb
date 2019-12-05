class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  has_one :address
  accepts_nested_attributes_for :address
  has_many :reports
  has_many :plans
  has_many :likes, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
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
  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 6, maximum: 128},on: :create
  validates :password_confirmation,   presence: true, confirmation: true, on: :create
  validates :age,presence:true, on: :update, numericality: { only_integer: true, greater_than: 0 }
  validates :height,presence:true, on: :update, numericality: { only_integer: true, greater_than: 0 }

  validates :sex,inclusion: {in: User.sexes.keys}, on: :update
  validates :activity,inclusion: {in: User.activities.keys}, on: :update

  def self.find_omniauth(auth)
    # SNSのuidとproviderを変数に代入
    uid = auth.uid
    provider = auth.provider
    # DBにすでにSNS情報を保存しているユーザーを検索し、snsに代入
    sns_register = SocialProfile.where(uid: uid, provider: provider).first
    if sns_register.present? #(パターン①)SocialProfileのDBに存在していれば登録ユーザーを返す
      user = User.where(id: sns_register.user_id).first
    else  #SocialProfileのDBに存在してない、SocialProfileにあるemailと同一のemailアドレスを持つユーザーを探す
      user_register = User.where(email: auth.info.email).first
      if user_register.present? #(パターン②)userがみつかったらSocialProfileのDBにレコード作成
        user = user_register
        SocialProfile.create(
              uid: uid,
              provider: provider,
              user_id: user.id
              )
      else #(パターン③)user見つからなければ
        user = User.new(
            nickname: auth.info.name,
            email: auth.info.email,
            )
      end
    end
    return user  #返り値はuser(3パターン)
  end

end
