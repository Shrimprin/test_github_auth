class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :repositories

  def self.form_omniauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.birth_day = Date.parse('1993-04-21')
      user.tel_number = '12345678'.to_i
    end
  end
end
