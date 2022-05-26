class GlobalConfigurationsController < ApplicationController
	def index
	end
  
  # New global configuration
	def create
    @globalconfig = GlobalConfiguration.new(config_params)
    if @globalconfig.save
      flash[:notice] = "Configuration is successfully added."
      redirect_to global_configurations_path
    else
      redirect_to global_configurations_path
    end
  end
  # Updating config value
  def update_config_value
    @globalconfigval = GlobalConfiguration.where(id: params[:config_value_id]).first
    if @globalconfigval.update(config_value: params[:config_value])
      flash[:notice] = "Configuration is updated successfully."
      redirect_to global_configurations_path
    else
      redirect_to global_configurations_path
    end
  end

  private
  # Define paramteres to be included
  def config_params
    params.require(:global_configuration).permit(:config_key, :config_value, :company_id)
  end
end
