class BooksController < ApplicationController

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
       redirect_to books_path
    end
    @book=Book.find(params[:id])

  end

  def update

    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have update book successfully."
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def index
    @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def destroy
    @book =Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def show
    @book_new=Book.new
    @book=Book.find(params[:id])

  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end




end
