class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer, notice: "削除しました"
  end

  def comments_all
    @comments = Comment.all.order(created_at: :desc) 
    @comments = Kaminari.paginate_array(@comments).page(params[:page]).per(20)
  end
end