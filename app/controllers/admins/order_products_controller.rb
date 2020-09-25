class Admins::OrderProductsController < ApplicationController
	before_action :authenticate_admin!

  #こっちのアクションは使わない？
  def update
  end
end
