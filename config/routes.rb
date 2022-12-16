Rails.application.routes.draw do
  resources :projects
  root to: "welcome#index"

  devise_for :users
end
