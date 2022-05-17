# == Schema Information
#
# Table name: companies
#
#  id                                :bigint           not null, primary key
#  name                              :string           not null
#  email                             :string           not null
#  website                           :string           not null
#  is_approved                       :boolean          default(FALSE), not null
#  boolean                           :boolean          default(FALSE), not null
#  add_approved_user_id_to_companies :string
#  approved_user_id                  :bigint           not null
#  admin_user_id                     :bigint
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
class Company < ApplicationRecord
  ## Associations
  belongs_to :admin_user

  ## validations 
  validates :name,:email presence: true
end
