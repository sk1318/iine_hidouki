class FavoritesController < ApplicationController
  def create
    @show_book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @show_book.id)
    favorite.save
  end
  
  def destroy
    @show_book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @show_book.id)
    favorite.destroy
  end
end
