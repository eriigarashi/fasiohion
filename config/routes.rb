Rails.application.routes.draw do
  # devise（ユーザー認証）
  devise_for :users

  # タグのルーティング（検索・ツイート・CRUD）
  resources :tags, only: [:index, :new, :create, :destroy] do
    collection do
      get 'search', to: 'tags#search'       # タグ名による検索
    end
    get 'tweets', to: 'tweets#search'       # タグに紐づくツイート検索（必要なら）
  end

  # ユーザー
  resources :users, only: [:show]

  # ブログとツイート
  resources :blogs
  resources :tweets
  delete 'tweets/:id' => 'tweets#destroy'  # この行はresources :tweetsに含まれているので不要かも

  # ルートページ
  root to: 'blogs#index'
end

