Rails.application.routes.draw do
  root 'desks#index'

  resources :desks
  resources :groupings, only: %i(show)

  namespace :admin do
    resources :layouts, only: %i(edit update)
  end

  mount ActionCable.server => '/cable'
end
