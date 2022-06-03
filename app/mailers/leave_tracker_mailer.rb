class LeaveTrackerMailer < ApplicationMailer

	def apply_leave_mail(leavetracker)
		@leavetracker = leavetracker
		mail(to:  User.where(role:1).select(:email).pluck(:email),
				subject: 'Application For Leave')
	end

	def approve_leave_mail(leavetracker)
    @leavetracker = leavetracker
    mail(to: @leavetracker.user.email,
    		subject: "Leave Approved")
  end

  def reject_leave_mail(leavetracker)
  	@leavetracker = leavetracker
  	mail(to: @leavetracker.user.email,
  			subject: "Leave Rejected")
  end
end
