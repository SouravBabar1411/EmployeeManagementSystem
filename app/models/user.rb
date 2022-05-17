# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  first_name             :string           not null
#  last_name              :string           not null
#  date_of_birth          :date             not null
#  is_active              :boolean          default(TRUE)
#  role                   :integer          default(0)
#  gender                 :string
#  image                  :string
#  password_changed_at    :datetime
#  company_id             :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  #validations
  validates :first_name, :last_name, :date_of_birth, presence: true

  #omniauth google social login
  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		user.provider = auth.provider
		user.uid = auth.uid
		user.email = auth.info.email
		user.password = Devise.friendly_token[0,20]
	  end
  end
end