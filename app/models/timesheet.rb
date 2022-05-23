# == Schema Information
#
# Table name: timesheets
#
#  id           :bigint           not null, primary key
#  string       :time             not null
#  description  :text             not null
#  is_approved  :boolean          default(FALSE), not null
#  user_id      :bigint           not null
#  project_id   :bigint           not null
#  job_id       :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Timesheet < ApplicationRecord
  ## Associations
  belongs_to :user
  belongs_to :project
  belongs_to :job

  ## Validations
  validates :time, :description,  presence: true 

  ## Modify JSON Response
  def as_json
    response = super
    response.merge!({user_name: self.user.first_name})
    response.merge!({project_name: self.project.name})
    response.merge!({job_name: self.job.name})
    response.merge!({startdate: self.created_at.strftime("%Y-%m-%d")})
    # response.merge!({workingtime: self.time.strftime("%I:%M")})
    response
  end
end