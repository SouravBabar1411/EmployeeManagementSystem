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
         :recoverable, :rememberable, :validatable
  
  ## Associations
  has_many :addresses, as: :addressable
  has_many :contact_infos, as: :contactable   
  has_many :notifications, as: :notificable 
  has_and_belongs_to_many :projects   
  has_and_belongs_to_many :jobs
  has_many :timesheets
  has_many :leave_trackers
end
