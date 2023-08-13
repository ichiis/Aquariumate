class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def index
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が成功しました"
    else
      @post = Post.new
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_correct_end_user
    @post = Post.find(params[:id])
    unless @post.end_user == current_end_user
      redirect_to posts_path
    end
  end
end
