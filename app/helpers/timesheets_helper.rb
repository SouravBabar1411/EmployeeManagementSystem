module TimesheetsHelper
  def button_text
    if controller.action_name == "new"
      return "Add Timesheet"
    elsif controller.action_name == "edit"
      return "Update Timesheet"
    else
      return "Submit"
    end
  end
end
