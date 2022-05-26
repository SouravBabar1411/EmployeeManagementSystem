module ProjectsHelper
  def button_value
    if controller.action_name == "new"
       return "Add Project"
    elsif controller.action_name == "edit"
       return "Update Project"
    else
       return "Submit"
    end
  end
end
