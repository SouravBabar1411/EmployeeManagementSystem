class TimesheetMailer < ApplicationMailer
  def send_timesheet_approve_email(timesheet)
    @timesheet = timesheet
    mail( :to => "sourav.itworks@gmail.com",
    :subject => 'Your Timesheet is approved.' )
  end
end