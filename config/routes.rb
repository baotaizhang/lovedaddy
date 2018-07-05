Rails.application.routes.draw do
  namespace :api do
    resources :messages, only: [:create, :destroy]
  end

  namespace :admin do
    get '/', to: 'dashboards#index'
    resources :dashboards, only: [:index]
    resources :users, only: [:index, :destroy]
    resources :birthday_credentials, only: [:index, :edit, :update]
    resources :income_credentials, only: [:index, :edit, :update]
  end

  resources :favorite_users, only: [:index, :create, :destroy], param: :to_user_id
  resources :block_users,    only: [:index, :create, :destroy], param: :blocked_user_id
  resources :display_unsubscribe_users, only: [:index, :create, :destroy], param: :to_user_id
  resources :image_viewable_users, only: [:index, :create, :destroy], param: :viewing_user_id

  resources :visit_histories, only: [:index, :destroy], param: :from_user_id

  resources :board_posts, path: 'boards' do
    collection do
      get :history
    end
  end

  resources :messages, only: [:index, :show], param: :url_token do
    collection do
      get :load
    end
  end

  resources :user_sessions
  resources :password_resets, only: [:create, :edit, :update]
  resources :users, only: [:index, :show, :new, :create, :edit, :update], param: :url_token do
    member do
      get :activate
    end
    collection do
      get :initial_edit
      put :initial_update
      get :thanks
      get :new_activation_mail
      post :create_activation_mail
    end
  end

  resources :options, only: [:index, :create]

  get  'login'  => 'user_sessions#new',     as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  get  'forget' => 'user_sessions#forget',  as: :forget

  resources :user_reports, only: [:new, :create]

  resources :birthday_credentials, only: [:index, :new, :create] do
    collection do
      get :thanks
    end
  end

  resources :income_credentials, only: [:new, :create] do
    collection do
      get :thanks
    end
  end

  resources :contacts, only: [:new, :create] do
    collection do
      get :thanks
    end
  end

  scope module: :homes do
    %i(about flow interview faq sitemap privacy_policy company agreement law limitation pricing antisocial).each do |page|
      get page
    end
  end

  scope module: :lps do
    %i(date).each do |page|
      get page
    end
  end

  root to: 'homes#top'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
