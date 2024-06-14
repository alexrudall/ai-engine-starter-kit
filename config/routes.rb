require "sidekiq/web"

Rails.application.routes.draw do
  resources :messages
  resources :assistant_threads do
    resources :messages, only: %i[create]
  end
  resources :storytellers

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "storytellers#index"

  mount Sidekiq::Web, at: "sidekiq"
end
