class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # and検索,マイナス検索可能
  def search
    @word = params[:word]
    words = params[:word].split(/[[:blank:]]+/).select(&:present?)
    negative_words, positive_words =
    words.partition {|word| word.start_with?("-") }
    # and検索
    @posts = Post.all
    positive_words.each do |word|
      @records =  @posts.where("body LIKE ?", "%#{word}%")
    end
    # マイナス検索
    negative_words.each {|word| word.slice!(/^-/) }
    negative_words.each do |word|
      next if word.blank?
      @records =  @posts.where.not("body LIKE ?", "%#{word}%")
    end
    @records = @records.reverse
    @pages = Kaminari.paginate_array(@records).page(params[:page]).per(10)
  end
end