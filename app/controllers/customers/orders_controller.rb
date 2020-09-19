class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Oder.new
  end

  def create
  end

  def index
  end

  def show
  end

  def update
  end

  def confirm
  end

  def thank
  end

  private

  def method_name
  end

  def method_name
  end

end
