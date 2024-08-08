Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "static_pages#top"

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update destroy]
  resources :password_resets, only: %i[new create edit update]

  #グループ機能用
  resources :groups, only: %i[new create index show edit update destroy] do
    get "summaries/:id/original" => "summaries#original", as: :original
    resources :summaries, only: %i[new create index show edit update destroy] do
      resource :like, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end
    resources :voices, only: %i[new create index show edit update destroy]
    resources :spots, only: %i[new create index show edit update destroy]
    resources :videos, only: %i[new create index edit update destroy]
    resource :permits, only: %i[create destroy]
    resource :group_users, only: %i[create destroy]
  end
  # createアクションとdestroyアクションとパスの名前が被ってしまうため、判別しやすいようにパスの名前を「permits_path」に指定
  get "groups/:id/permits" => "groups#permits", as: :permits


  #個人機能用
  resources :personal_summaries, only: %i[new create index show edit update destroy] do
    member do
      get :original
    end
    resource :personal_like, only: %i[create destroy]
    resources :personal_comments, only: %i[create destroy]
  end
  resources :personal_voices, only: %i[new create index show edit update destroy]
  resources :personal_spots, only: %i[new create index show edit update destroy]
  resources :personal_videos, only: %i[new create index edit update destroy]


  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'oauths/oauth'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
