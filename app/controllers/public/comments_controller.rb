class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  
  def create
    post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to request.referer
    else
      flash[:alert] = 'コメントを入力してください。（コメントは200文字以内です。）'
      redirect_to request.referer
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
