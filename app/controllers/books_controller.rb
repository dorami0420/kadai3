class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def new

  end

  def index
   @book = Book.new
   @user = current_user
   @books = Book.all

  end

  def show
@book = Book.find(params[:id])
@user = @book.user
@new = Book.new
  end


  def edit
      flash[:notice] = "You have updated book successfully."
     @book = Book.find(params[:id])

  end



  def create
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
    else
        render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
