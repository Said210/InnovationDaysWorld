Rails.application.routes.draw do
  resources :projects
  root to: "projects#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
