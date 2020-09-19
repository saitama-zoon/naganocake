class Admins::ProductsController < ApplicationController
	before_action :authenticate_admin!
end
