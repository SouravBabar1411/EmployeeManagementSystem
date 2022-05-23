class AddressesController < ApplicationController
  before_action :set_address, only: %i[ edit update destroy ]

  def index
    @addresses = Address.all
  end


  def new
    @address = Address.new
 
  end


  def edit
  end

  def create
    @address = Address.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to root_path, notice: "address was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to root_path, notice: "address was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresss_url, notice: "address was successfully destroyed." }
      format.json { head :no_content }
    end
  end
 
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:addressable_id,:addressable_type,:address_line_1, :address_line_2, :city, :country,:state, :zipcode)
  end

end