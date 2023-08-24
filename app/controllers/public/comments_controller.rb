class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_id = @post.id
    unless @comment.save
      render 'error'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def ensure_correct_end_user
    @comment = Comment.find(params[:id])
    unless @comment.end_user == current_end_user
      redirect_to posts_path
    end
  end
end