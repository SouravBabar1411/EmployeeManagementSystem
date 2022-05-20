class AddressesController < ApplicationController
  def new 
    binding.pry
    @address = @addressable.address.new
  end

  def create
    @address = @addressable.address.new(address_params)
    @address.save
    if @address.save
      redirect_to @addressable, notice: "Your address was created successfully"
    else
      redirect_to root_path
    end
  end

  private 
  def address_params
    params.require(:address).permit(:address_line_1,:address_line_2,:city,:country,:state,:zipcode)
  end
end