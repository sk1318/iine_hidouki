class BooksController < ApplicationController
  before_action :book_edit_check,only: [:edit]
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id

    if @book.save
    flash[:success]="You have created book successfully."
    redirect_to book_path(@book)
    else
     @user = current_user
     @books = Book.all
     render template: "books/index"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @show_book = Book.find(params[:id])
    @user = @show_book.user
    @book = Book.new
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
    flash[:success] ="You have updated book successfully."
    redirect_to book_path(@book)
    else
    render :edit
    end
  end

  def destroy
     @book = Book.find(params[:id])
     @book.destroy
     redirect_to books_path
  end

  private

  def books_params
    params.require(:book).permit(:title,:body)
  end

  def book_edit_check
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

end
