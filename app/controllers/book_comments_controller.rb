class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comments_params)
    book_comment.book_id = book.id
    if book_comment.save
    redirect_to book_path(book)
    else
      redirect_back(fallback_location: root_path)
      flash[:error] = "投稿できませんでした"
    end

  end


  def destroy
   book = Book.find(params[:book_id])
   book_comment =  BookComment.find_by(id: params[:id],book_id: params[:book_id])
   book_comment.destroy
   redirect_to book_path(book)

  end

  private

  def book_comments_params
    params.require(:book_comment).permit(:comment)
  end
end
