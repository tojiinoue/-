class DiariesController < ApplicationController
  def index
    @diaries = Diary.page(params[:page]).per(10)
    @diary = Diary.new
  end

  def show
    @diary = Diary.find(params[:id])
  end
  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    if  @diary.save
      flash[:notice] = "successfully"
      redirect_to diary_path(@diary)
    else
      @diaries = Diary.page(params[:page]).per(10)
      render :index
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    if @diary.user_id == current_user.id
      render "edit"
    else
      redirect_to diaries_path
    end
  end

  def update
    @diary = Diary.find(params[:id])
    @diary.user_id = current_user.id
    if @diary.update(diary_params)
      flash[:notice] = "successfully"
      redirect_to diary_path(@diary)
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private
  def diary_params
    params.require(:diary).permit(:title, :body)
  end
end
