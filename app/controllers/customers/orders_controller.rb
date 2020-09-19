class Customers::OrdersController < ApplicationController

  #new viewからcofirm action宛に入力内容を送信
  def new
    @order = Order.new
  end

  def create
  end

  def index
    @orders = @customer.orders
  end

  def show
  end

  #?
  def update
  end

  #new viewから入力値を受け取り条件に合わせて分岐処理
  def confirm
    @order = Order.new
    @cart_products = current_customer.carts
    @order.payment_method = params[:order][:payment_method]

    #送り先のラジオボタンによる選択
    #:add→new viewにて定義 受領する値:1~3にて処理分岐
    @add = params[:order][:add].to_i
    #取得した値に対してcase文で条件分岐
    case @add
    #自身の住所

      when 1
        ### 要動作確認 ###
        @order.postal_code = @customer.postal_code
        @order.address = @customer.address
        @order.name = @customer.first_name + @customer.last_name

      #登録済み住所
      #new view プルダウン部で定義したselect_to_addressより値を取得
      when 2
        #登録済み住所の情報取得メソッド...要動作確認
        @select_to_address = params[:order][:select_to_address]
        @send_to_address = Destination.find(@select_to_address)

        @order.postal_code = @send_to_address.postal_code
        @order.address = @send_to_address.address
        @order.name = @send_to_address.name

      #新規発送先
      when 3
        #:new_add→new viewにて定義
        @order.postal_code = params[:order][:new_add][:postal_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][:new_add][:name]
    end
  end

  #session actionは使用せずに処理可能かも?
  def session
  end

  def thank
  end

  private

  def set_customer
    @customer = current_customer
  end

  #order_productsとの紐付け必要...
  def order_params
    params.require(:order).oermit(
      :create_at, :postal_code, :address, :name, :shipping, :payment_method, :order_status
      )
  end

end
