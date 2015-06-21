class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]
  before_action :not_signed_user, except: [:index, :show]
  before_action :authenticate_admin, if: :signed_in?, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "The book successfully added."
      redirect_to @book
    else
      flash[:danger] = "The form contains some errors."
      render :new
    end
  end

  def update
    if @book.update(book_params)
      flash[:success] = "The book successfully updated."
      redirect_to @book
    else
      flash[:danger] = "The form contains some errors."
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def load_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :price, :stock)
  end
end
