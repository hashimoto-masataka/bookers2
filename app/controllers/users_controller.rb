class UsersController < ApplicationController


  def new
    @user=User.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
     redirect_to book_path(params[:id])
    else
      render :new
    end
  end


  def index
    @users=User.all
    @user=current_user
    @book=Book.new
  end


  def show
    @user=User.find(params[:id])
    @books=@user.books
    @book=Book.new


  end

  def edit
    @user=User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user)
    end
    @book=Book.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end


end
