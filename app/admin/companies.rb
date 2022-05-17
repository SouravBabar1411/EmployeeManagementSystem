ActiveAdmin.register Company do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :website, :is_approved, :boolean, :add_approved_user_id_to_companies, :approved_user_id, :admin_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :website, :is_approved, :boolean, :add_approved_user_id_to_companies, :approved_user_id, :admin_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
