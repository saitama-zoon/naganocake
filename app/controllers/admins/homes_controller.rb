class Admins::HomesController < ApplicationController

  before_action :authenticate_admin!

  def home
  	start_date = Time.current.beginning_of_day
	end_date = Time.current.end_of_day
	@todays_order = Order.where(created_at: start_date..end_date).pluck(:created_at).count

  end

  def about
  end

end