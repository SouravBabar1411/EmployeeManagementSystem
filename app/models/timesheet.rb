# == Schema Information
#
# Table name: timesheets
#
#  id           :bigint           not null, primary key
#  current_date :date             not null
#  time         :time             not null
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
  validates :current_date, :time, :description, :is_approved, presence: true 
end
