Rails.application.routes.draw do
  root 'desks#index'

  resources :desks
  resources :groupings, only: %i(show edit update)

  mount ActionCable.server => '/cable'
end
