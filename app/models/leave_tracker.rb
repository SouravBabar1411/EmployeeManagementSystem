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
  validates :from_date, :to_date, :reason, presence: true 
  validate :must_have_valid_from_date 

  def must_have_valid_from_date
    if from_date != Date.today - 3.days
      errors.add(:from_date, "Applay for leave before 3 days.")
    end
  end

  def as_json 
    response = super
    response.merge!({emp_name: self.user.first_name})
    response
  end 
end
