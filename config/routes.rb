Rails.application.routes.draw do
  #admin用認証機能
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  #end_user用認証機能
  devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  #end_userルートパス
  root to:'public/homes#top'
  #admin用パス
  namespace :admin do
    resources :end_users, only: [:show, :index, :edit, :update]
    resources :posts, only: [:show, :index, :destroy]
    resources :post_images, only: [:show, :index, :destroy]
    resources :comments, only: [:show, :index, :destroy]
    resources :tags, only: [:index, :destroy]
  end
  #end_user用パス
  scope module: :public do
    resources :end_users
    resources :posts
    resources :post_images
    resources :comments
    resources :tags
    resources :favorite_posts
    resources :favorite_post_images
    resources :favorite_post_and_tags
  end
end
