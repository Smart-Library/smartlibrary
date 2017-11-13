Rails.application.routes.draw do
  root 'desks#index'

  resources :desks

  mount ActionCable.server => '/cable'
end
