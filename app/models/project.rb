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
  has_many :jobs , dependent: :destroy
  has_many :timesheets , dependent: :destroy

  ## Validations
  validates :name, :start_date, presence: true 

  ## callbacks
  after_save {id = self.id}

  def as_json 
    response = super
    response.merge!(user_name: self.users.select(:first_name).pluck(:first_name))
    response.merge!(jobs: self.jobs.select(:name).pluck(:name))
    response.merge!(jobs_count: self.jobs.count)
    response.merge!(users_count: self.users.count)
    response
  end 
end
