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
    resources :posts, only: [:show, :index, :destroy] do
      resources :comments, only: [:destroy]
    end
    #resources :post_images, only: [:show, :index, :destroy]
    resources :tags, only: [:index, :destroy]
    get 'search'=> 'searches#search'
    get "search_tag" => "posts#search_tag"
    get "comments"=> "comments#comments_all"
  end
  #end_user用パス
  scope module: :public do
    resources :posts do
      resource :favorite_posts, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    #resources :post_images
    resources :tags
    #resources :favorite_post_images
    resources :post_and_tags
    get  'end_users/confirm_withdraw' => 'end_users#confirm_withdraw'
    patch  'end_users/withdraw' => 'end_users#withdraw'
    resources :end_users do
      member do
        get :favorite_posts
      end
    end
    get 'search'=> 'searches#search'
    get "search_tag" => "posts#search_tag"
  end
  #ゲストログイン用パス
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
end
