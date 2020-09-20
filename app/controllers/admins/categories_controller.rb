class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to request.referer
  end

  def edit
  	@category = Category.find[:id]
  end

  def update
  	@category = Category.find[:id]
    @category.update
    redirect_to category_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :is_effective)
  end

end
