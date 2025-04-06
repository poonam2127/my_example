Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions", passwords: "users/passwords",
    registrations: "users/registrations"
  }

  root "questions#index"

  resources :questions do
    resources :answers, only: [ :create ] do
      member do
        post :approve_payment
      end
    end
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  get "lawyer", to: "lawyers#index"
end
