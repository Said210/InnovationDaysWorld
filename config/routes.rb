Rails.application.routes.draw do
  resources :projects
  post "/projects/:id/join", to: "projects#join", as: :join_project
  post "/projects/:id/leave", to: "projects#join", as: :leave_project

  root to: "projects#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
