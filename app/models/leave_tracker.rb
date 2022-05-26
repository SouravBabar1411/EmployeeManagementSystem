# == Schema Information
#
# Table name: leave_trackers
#
#  id          :bigint           not null, primary key
#  from_date   :date             not null
#  to_date     :date             not null
#  reason      :text             not null
#  is_approved :boolean          default(FALSE), not null
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class LeaveTracker < ApplicationRecord
  ## Associations
  belongs_to :user

  ## Validations
  validates :from_date, :to_date, :reason, :is_approved, presence: true 

  def as_json 
    response = super
    response.merge!({emp_name: self.user.first_name})
    response
  end 
end
