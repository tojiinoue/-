class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries.page(params[:page]).per(15)
    @diary = Diary.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
