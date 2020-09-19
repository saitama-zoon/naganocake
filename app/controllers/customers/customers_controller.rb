class Customers::CustomersController < ApplicationController
	before_action :authenticate_customer!
end
