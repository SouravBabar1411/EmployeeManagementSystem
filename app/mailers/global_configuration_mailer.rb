class GlobalConfigurationMailer < ApplicationMailer
	default from: 'prabhanshu.itworks@gmail.com'

	def policy_mail
		@user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Update on Company Policy')
	end
end
