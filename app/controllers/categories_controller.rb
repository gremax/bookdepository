class CategoriesController < ApplicationController
  before_action :not_signed_user
  before_action :authenticate_admin, if: :signed_in?

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "The category successfully created."
      redirect_to categories_path
    else
      flash[:danger] = "The form contains some errors."
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
