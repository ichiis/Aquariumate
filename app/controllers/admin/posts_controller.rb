class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_images = @post.post_images
  end

  def index
    @posts = Post.page(params[:page]).per(10)
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc) 
  end
  
  def edit
     @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
  
  private

  def post_params
    params.require(:post).permit(images: [])
  end
end
