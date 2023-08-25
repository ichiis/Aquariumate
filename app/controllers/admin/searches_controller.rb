class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    if params[:word].present?
      @word = params[:word]
      @records = EndUser.search_for(@word)
      @pages = Kaminari.paginate_array(@records).page(params[:page]).per(10)
    else
      redirect_to admin_end_users_path, notice:"キーワードを入力してください"
    end
  end
end