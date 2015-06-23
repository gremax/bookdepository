class AuthorsController < ApplicationController
  before_action :not_signed_user
  before_action :authenticate_admin, if: :signed_in?

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = "The author successfully created."
      redirect_to authors_path
    else
      flash.now[:danger] = "The form contains some errors."
      render :new
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      flash[:success] = "The author successfully updated."
      redirect_to authors_path
    else
      flash.now[:danger] = "The form contains some errors."
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit(:firstname, :lastname, :biography)
  end
end
