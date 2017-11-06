Rails.application.routes.draw do
  root 'desks#index'

  resources :desks
end
