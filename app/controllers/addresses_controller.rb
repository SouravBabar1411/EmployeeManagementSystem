class AddressesController < ApplicationController
  def new 
    @address = @addressable.addresses.new
  end

  def create
    @address = @addressable.addresss.new(address_params)
    binding.pry
    @address.save
    redirect_to @addressable, notice: "Your address was created successfully"
  end

  private 
  def address_params
    params.require(:address).permit(:address_line_1,:address_line_2,:city,:country,:state,:zipcode)
  end
end