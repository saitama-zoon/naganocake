class Admins::CustomersController < ApplicationController
  	before_action :authenticate_admin!
	def index
		@customers=Customer.all
		# 会員情報を全てインスタンスに挿入
	end

	def show
		@customer=Customer.find(params[:id])
	end

	def edit
		@customer=Customer.find(params[:id])
	end

	def update
		@customer=Customer.find(params[:id])
		if @customer.update(customer_params)
		   redirect_to admins_customer_path(@customer.id)
		else
      		render "edit"
    	end
	end

	private
	def customer_params
		params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:adress,:phone_number,:is_member)
  end
end
