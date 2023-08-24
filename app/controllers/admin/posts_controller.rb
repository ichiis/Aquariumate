class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
    @post_and_tags = @post.tags
    @comment = @post.comments
  end

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc) 
  end

  def images
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc) 
  end

  def edit
     @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました"
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order(created_at: :desc) 
    @page = @posts.page(params[:page]).per(10)
  end
end