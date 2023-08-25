class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # and検索,マイナス検索可能
  def search
    if params[:word].present?
      @word = params[:word]
      words = params[:word].split(/[[:blank:]]+/).select(&:present?)
      negative_words, positive_words =
      words.partition {|word| word.start_with?("-") }
      # and検索
      @posts = Post.all
      positive_words.each do |word|
        @posts =  @posts.where("body LIKE ?", "%#{word}%")
      end
      # マイナス検索
      negative_words.each do |word|
        next if word.blank?
        @posts = @posts.where!("body NOT LIKE ?", "%#{word.delete_prefix('-')}%")
      end
      @posts = @posts.order(created_at: :desc) 
      @pages = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    else
      redirect_to posts_path, notice:"キーワードを入力してください"
    end
  end  
end