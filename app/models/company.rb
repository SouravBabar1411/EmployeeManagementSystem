# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  email       :string           not null
#  website     :string
#  is_approved :boolean          default(FALSE), not null
#  boolean     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Company < ApplicationRecord
  ## validations 
  validates :name,:email, presence: true
  ## Associations
  has_many :addresses, as: :addressable  
  has_many :contact_infos, as: :contactable 
  has_many :projects
  has_many :global_configurations

  # def active_for_authentication? 
  #   super && is_approved?
  # end 
    
  # def inactive_message 
  #   is_approved? ? super : :not_approved
  # end
end
