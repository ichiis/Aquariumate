class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  
  def search
    @word = params[:word]
    @records = Post.search_for(@word)
    @page = @records.page(params[:page]).per(10)
  end
  
end
