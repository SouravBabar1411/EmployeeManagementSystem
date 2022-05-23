module AddressesHelper
  def button_text
    if controller.action_name == "new"
       return "Add Address"
    elsif controller.action_name == "edit"
       return "Update Address"
    else
       return "Submit"
    end
  end
end
