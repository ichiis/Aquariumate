class Public::FavoritePostsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite_post = current_end_user.favorite_posts.new(post_id: @post.id)
    favorite_post.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite_post = current_end_user.favorite_posts.find_by(post_id: @post.id)
    favorite_post.destroy
  end
end
