class ProjectAssignMailer < ApplicationMailer

	def project_assign(project)
		@project = project
		mail(to: @project.users.select(:email).pluck(:email),
			subject: "New Project is assign to You.")
	end 
end
