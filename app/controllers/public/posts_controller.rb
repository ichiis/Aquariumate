class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_and_tags = @post.tags
    @comment = Comment.new
  end

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc) 
    @tag_list = Tag.all
  end

  def images
    #1ページあたり投稿10件分の画像
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc) 
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    # 入力されたタグを,で区切る
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿が成功しました"
    else
      render 'public/posts/new'
    end
  end

  def edit
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    # #添付画像を個別に削除
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end
    tag_list=params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      @tag_list = @post.tags.pluck(:tag_name).join(',')
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  #タグ検索
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end


  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end

  def ensure_correct_end_user
    @post = Post.find(params[:id])
    unless @post.end_user == current_end_user
      redirect_to posts_path
    end
  end
end
