class Customers::DestinationsController < ApplicationController
	before_action :authenticate_customer!
end
