class JobCreatedMailer < ApplicationMailer

  def job_assign(job)
    @job = job
    mail( :to => 'pratiksha.itworks@gmail.com',
      :subject => 'New job is assign.')
  end
end
