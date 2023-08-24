class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @records = EndUser.search_for(@word)
    @pages = Kaminari.paginate_array(@records).page(params[:page]).per(10)
  end
end