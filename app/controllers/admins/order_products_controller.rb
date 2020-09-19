class Admins::OrderProductsController < ApplicationController
	before_action :authenticate_admin!
end
