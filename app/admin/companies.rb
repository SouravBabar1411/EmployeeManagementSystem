ActiveAdmin.register Company do

  permit_params :name, :email, :website, :is_approved, :boolean
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :website
    column :is_approved
    actions 
  end

  controller do 
    ## for update approve column
    def update 
      @company = Company.find(params[:id])
      if @company.is_approved = 'false'
        @company.is_approved = 'true'
      else  
        @company.is_approved = 'false'
      end
      @company.save
        CompanyApproveMailer.send_approve_email(@company).deliver
        redirect_to(admin_companies_path, :notice => 'Company Approved.')
    end 
  end 
  
end
