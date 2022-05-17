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
end
