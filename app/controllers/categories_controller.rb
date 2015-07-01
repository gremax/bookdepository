class CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]
  before_action :not_signed_user, except: :show
  before_action :authenticate_admin, if: :signed_in?, except: :show

  def index
    @categories = Category.all
  end

  def show
    @books = @category.books
  end

  def new
    @category = Category.new
  end

  def edit
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
    if @category.update(category_params)
      flash[:success] = "The category successfully updated."
      redirect_to categories_path
    else
      flash[:danger] = "The form contains some errors."
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:warning] = "The category successfully removed."
    redirect_to categories_path
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
