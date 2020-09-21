class Customers::DestinationsController < ApplicationController
  before_action :authenticate_customer!

  def show
  	@destination = Destination.find(params[:id])
  end

  def index
  	@destination = Destination.new
    @destinations = Destination.all
  end

  def create
  	@destination = Destination.new(destination_params)
    @destination.customer_id = current_customer.id

    if @destination.save
      flash[:notice] = "You have created book successfully."
      redirect_to destinations_path
    else
      @destinations = Destination.all
      render :index
    end
  end

  def edit
  	@destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path, notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def destroy
     @destination = Destination.find(params[:id])
     @destination.destroy
     redirect_to destinations_path
  end

private

  def destination_params
	  params.require(:destination).permit(:postal_code, :address, :name, :customer_id)
  end

end
