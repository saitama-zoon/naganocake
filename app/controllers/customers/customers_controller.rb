class Customers::CustomersController < ApplicationController
  
  before_action :authenticate_customer!
  
  def show
  	@customer = current_customer
  end

  def withdrawl
    @customer = current_customer
    #現在ログインしているユーザーを@customerに格納
    @customer.update(is_dactive: "Invalid")
    #updateで登録情報をInvalidに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    #指定されたrootへのpath
  end

  def edit
  	@customer = current_customer
  end

  def update
  	@customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path, notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

private
  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:phone_number,:is_member,:email)
  end

end
