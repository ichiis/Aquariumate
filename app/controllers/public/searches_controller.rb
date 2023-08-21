class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  
  def search
    @word = params[:word]
    @records = Post.search_for(@word)
    @records_view = @records.reverse
    @records_view = Kaminari.paginate_array(@records_view).page(params[:page]).per(10)
  end
  
end
