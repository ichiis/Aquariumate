class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    # @post.build_post_image
  end

  def show
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
    @post_and_tags = @post.tags
    @post_images = @post.post_images
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    tag_list = params[:post][:tag_name].split(',')

    if @post.save
    # 保存された投稿に紐づく画像を保存
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿が成功しました"
    else
      @post = Post.new
      render 'new'
    end
  end

  def edit
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    tag_list=params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
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
    params.require(:post).permit(:title, :body, images: [])
  end

  def ensure_correct_end_user
    @post = Post.find(params[:id])
    unless @post.end_user == current_end_user
      redirect_to posts_path
    end
  end
end
