class AuthorsController < ApplicationController
  before_action :not_signed_user
  before_action :authenticate_admin, if: :signed_in?

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
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

  private

  def author_params
    params.require(:author).permit(:firstname, :lastname, :biography)
  end
end
