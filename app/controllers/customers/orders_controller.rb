class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer


  def new
    @order = Order.new
    #これだと全部取得してしまう
    @customer_address = Destination.all

  end

  def create
    if current_customer.cart.exists?
      @order = Order.new(order_params)
      @order.customer_id = current_customet.id

      #送り先情報をorderへ保存
      case @add
        when 1
          @order.post_code = @customer.post_code
          @order.address = @customer.address
          @order.name = @customer.first_name + @customer.last_name
        when 2
          @order.post_code = params[:order][:post_code]
          #@order.send_to_address = params[:order][]
          @order.address = params[:order][:send_to_address]
          @order.name = params[:order][:addressee]
        when 3
          @order.post_code = params[:order][:post_code]
          @order.address = params[:order][:send_to_address]
          @order.name = params[:order][:addressee]
      end
      @order.save

      #dstnationモデル検索、未登録時に新規登録
      if Destination.find_by(address: @order.send_to_address).nil?
        @destination = Destination.new
        @destination.post_code = @order.post_code
        @destination.address = @order.send_to_address
        @destination.name = @order.name
        @destination.customer_id = current_customer.id
        @destination.save
      end

        current_customer.cart_puroducts.each do |cart_puroduct|
          order_product = @order.order_items.build
          order_product.order_id = @order.id
          order_product.product_id = cart_puroduct.product_id
          order_product.quantity = cart_puroduct.quantity
          order_product.order_price = cart_puroduct.product.price
          order_product.save
          #order_productに情報を移したらcart_puroductは消去
          cart_puroduct.destroy
        end

        render :thank

    else
      redirect_to customer_top_path　flash[:danger] = 'カート空'
    end
  end

  def index
    @orders = @customer.orders
  end

  def show
    #@order = Order.find[params[:id]]
  end

  #?
  def update
  end

  #new viewから入力値を受け取り条件に合わせて分岐処理
  def confirm
    @order = Order.new

    #current_customerのcar中身を代入
    @cart_products = current_customer.cart_products

    #:how_to_pay→new viewにて定義
    @order.payment_method = params[:order][:how_to_pay]


    #送り先のラジオボタンによる選択
    #:add→new viewにて定義 受領する値:1~3にて処理分岐
    @add = params[:order][:add].to_i
    #取得した値に対してcase文で条件分岐
    case @add
    ### 要動作確認 ###

      when 1
        #自身の住所
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


  #注文完了画面を表示するのみ
  def thank
  end

  private

  def set_customer
    @customer = current_customer
  end

  #order_productsとの紐付け必要...
  def order_params

    params.require(:order).permit(

      :create_at, :postal_code, :address, :name, :shipping, :payment_method, :order_status
      )
  end


end
