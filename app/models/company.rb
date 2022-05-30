# == Schema Information
#
# Table name: companies
#
#  id                                :bigint           not null, primary key
#  name                              :string           not null
#  email                             :string           not null
#  website                           :string           not null
#  is_approved                       :boolean          default(FALSE), not null
#  add_approved_user_id_to_companies :string
#  approved_user_id                  :bigint           not null
#  admin_user_id                     :bigint
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
class Company < ApplicationRecord
  ## Associations
  has_many :users
  has_many :addresses, as: :addressable  
  has_many :contact_infos, as: :contactable 
  has_many :projects , dependent: :destroy
  has_many :global_configurations , dependent: :destroy

  ## validations 
  validates :name,:email, presence: true
  validates :email, uniqueness: true
end
