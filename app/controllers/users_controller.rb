class UsersController < ApplicationController

  def new
  end

  def index
  @user = current_user
  @users = User.all
  @book = Book.new
  end

  def show
  @user = User.find(params[:id])
  @users = User.all
  @book = Book.new
  @books = @user.books
  end


  def create
     flash[:notice] = "You have create user successfully."
  end

  def edit
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
  end


  def update
      @user = current_user
  if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
      redirect_to user_path
  else
      render :edit
  end
  end

private

  def user_params
  params.require(:user).permit(:name, :introduction, :image)
  end

  def is_matching_login_user
    user = Book.find(params[:id])
  unless user.id == current_user.id
      redirect_to book_path
  end

  end
end
