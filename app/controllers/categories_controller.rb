class CategoriesController < ApplicationController
  before_action :not_signed_user
  before_action :authenticate_admin, if: :signed_in?

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
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

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "The category successfully updated."
      redirect_to categories_path
    else
      flash[:danger] = "The form contains some errors."
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
