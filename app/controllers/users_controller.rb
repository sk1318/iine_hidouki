class UsersController < ApplicationController
  before_action :user_edit_check, only: [:edit]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
       if @user.update(users_params)
         flash[:success] = "You have updated user successfully."
         redirect_to user_path(current_user.id)
       else
         render :edit
       end
  end

  
  private
  
  def users_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
  
  def user_edit_check
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end
  
  
end
