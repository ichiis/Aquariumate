class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  def comments_all
    @comments = Comment.all.order(created_at: :desc) 
  end
end
