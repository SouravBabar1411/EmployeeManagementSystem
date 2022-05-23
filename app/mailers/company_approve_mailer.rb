class CompanyApproveMailer < ApplicationMailer
  # default :from => 'any_from_address@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_approve_email(company)
    @company = company
    mail( :to => @company.email,
    :subject => 'Thanks for signing up.' )
  end
end