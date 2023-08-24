class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.order(created_at: :desc) 
    @end_users = Kaminari.paginate_array(@end_users).page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page]).per(5).order(created_at: :desc)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user), notice: "更新しました"
    else
      render :edit
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :is_deleted)
  end
end
