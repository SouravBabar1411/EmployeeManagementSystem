class TimesheetMailer < ApplicationMailer

  def send_timesheet_approve_email(timesheet)
    @timesheet = timesheet
    mail(:to => @timesheet.user.email,
    :subject => 'Your Timesheet has been approved by admin.' )
  end
end