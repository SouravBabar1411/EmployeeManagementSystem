# == Schema Information
#
# Table name: jobs
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  is_active  :boolean          not null
#  project_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Job < ApplicationRecord
  ## Associations
  belongs_to :project
  has_and_belongs_to_many :users
  has_many :timesheets

  def as_json 
    response = super 
    response.merge!(project_name: self.project.name,user_name: self.users.select(:first_name).pluck(:first_name))
    response.merge!(users_count: self.users.count)
  end 
end
