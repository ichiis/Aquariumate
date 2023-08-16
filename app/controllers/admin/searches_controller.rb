class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @word = params[:word]
    @records = EndUser.search_for(@word)
    @page = @records.page(params[:page]).per(10)
  end
end
