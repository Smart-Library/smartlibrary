Rails.application.routes.draw do
  root 'desks#index'

  resources :desks

  namespace :admin do
    resources :layouts, only: %i(edit update)
  end

  mount ActionCable.server => '/cable'
end
