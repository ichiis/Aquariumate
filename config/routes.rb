Rails.application.routes.draw do
  #admin認証機能
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  #end_user認証機能
  devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  #ルートパス
  root to:'public/homes#top'
  #admin用パス
  namespace :admin do
    resources :end_users, only: [:show, :index, :edit, :update]
    resources :posts, only: [:show, :index, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:index, :destroy]
    #ユーザー検索
    get 'search'=> 'searches#search'
    get "search_tag" => "posts#search_tag"
    get "comments"=> "comments#comments_all"
    get "images"=> "posts#images"
  end
  
  #end_user用パス
  scope module: :public do
    resources :posts do
      resource :favorite_posts, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    #退会機能(下2行)
    get  'end_users/confirm_withdraw' => 'end_users#confirm_withdraw'
    patch  'end_users/withdraw' => 'end_users#withdraw'
    resources :end_users, only: [:show, :edit, :update] do
      member do
        get :favorite_posts
      end
    end
    get 'search'=> 'searches#search'
    get "search_tag" => "posts#search_tag"
    get "images"=> "posts#images"
  end
  #ゲストログイン用パス
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
end
