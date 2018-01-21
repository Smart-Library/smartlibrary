Rails.application.routes.draw do
  root 'desks#index'

  resources :desks
  resources :groupings

  mount ActionCable.server => '/cable'
end
