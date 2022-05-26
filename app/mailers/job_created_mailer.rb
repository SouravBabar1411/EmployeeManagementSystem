class JobCreatedMailer < ApplicationMailer

  def job_assign(job)
    @job = job
    mail(to: @job.users.select(:email).pluck(:email),
    subject: "New job assign to you.")
  end
end
