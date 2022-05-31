# == Schema Information
#
# Table name: leave_trackers
#
#  id          :bigint           not null, primary key
#  from_date   :date             not null
#  to_date     :date             not null
#  reason      :text             not null
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_approved :boolean          default(FALSE)
#
class LeaveTracker < ApplicationRecord
  ## Associations
  belongs_to :user

  ## Validations
  validates :from_date, :to_date, :reason, presence: true 
  validate :must_have_valid_from_date

  def must_have_valid_from_date
    global_val = GlobalConfiguration.where(config_key: "takeleavebefore").pluck(:config_value)    
    # binding.pry
    if from_date <= Date.today + global_val[0].days
      errors.add(:from_date, "apply before #{global_val[0]} days")
    end
  end

  def as_json 
    response = super
    response.merge!({emp_name: self.user.first_name})
    response
  end 
end
