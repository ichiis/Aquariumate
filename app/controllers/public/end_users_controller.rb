class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page]).per(10)
  end
  
  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user), notice: "更新しました"
    else
      render "edit"
    end
  end
  
  def confirm_withdraw
  end
  
  def withdraw
    @end_user = EndUser.find(current_end_user.id)
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, :email)
  end

  def ensure_correct_end_user
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end
  
  def ensure_guest_user
    @end_user = EndUser.find(params[:id])
    if @end_user.email == "guest@example.com"
      redirect_to end_user_path(current_end_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
