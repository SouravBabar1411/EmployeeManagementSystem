module JobsHelper
  def action_text
    if controller.action_name == "new"
       return "Add Job"
    elsif controller.action_name == "edit"
       return "Update Job"
    else
       return "Submit"
    end
  end
end
