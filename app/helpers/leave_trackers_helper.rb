module LeaveTrackersHelper
	def button_leave
		if controller.action_name == "new"
		  return "Apply Leave"
		elsif controller.action_name == "edit"
		  return "Update Leave"
		else
		  return "Submit"
		end
	end
end
