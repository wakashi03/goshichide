Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "tops#index"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_service', to: 'tops#terms_of_service'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # post '/callback', to: 'linebot#callback'

  get 'senryus/ranking', to: 'senryus#ranking'

  resources :users, only: %i[new create]
  resources :senryus do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :favorites
      get 'ranking'
      get :user_senryus
    end
  end
  resources :favorites, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
end
