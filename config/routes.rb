Rails.application.routes.draw do
  resources :editions
  resources :projects
  post "/projects/:id/join", to: "projects#join", as: :join_project
  post "/projects/:id/leave", to: "projects#leave", as: :leave_project

  post "/projects/:id/vote", to: "projects#vote", as: :vote_project
  post "/projects/:id/cancel_vote", to: "projects#cancel_vote", as: :cancel_vote

  root to: "projects#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
