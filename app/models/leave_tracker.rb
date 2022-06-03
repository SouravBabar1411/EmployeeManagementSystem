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
  validate :leave_count

  def must_have_valid_from_date
    global_val = GlobalConfiguration.where(config_key: "takeleavebefore").pluck(:config_value)    
    if from_date <= Date.today + global_val[0].days
      errors.add(:base, "apply for leave  before #{global_val[0]} days")
    end
  end

  def leave_count
    leave = GlobalConfiguration.where(config_key: "totalleaves").pluck(:config_value)
    # user_leave_count = self.user.leave_trackers.count
    # if leave[0] <= user_leave_count
    #   errors.add(:base, "your leave's are over")
    # end
  end

  def as_json 
    response = super
    response.merge!({emp_name: self.user.first_name})
    response
  end 
end