# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  start_date :date             not null
#  end_date   :date
#  is_active  :boolean          default(TRUE)
#  company_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  ## Associations
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :jobs
  has_many :timesheets

  ## Validations
  validates :name, :start_date, presence: true 
end
