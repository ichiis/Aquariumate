class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @tags = Tag.page(params[:page]).per(20).order(created_at: :desc) 
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path, alert: "タグを削除しました。"
  end
end
