Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id/show_profile', to: 'users#show_profile', as: 'show_profile'
  get '/users/:id/show_account', to: 'users#show_account', as: 'show_account'
  get '/users/:id/edit_profile', to: 'users#edit_profile', as: 'edit_profile'
  get '/users/:id/edit_account', to: 'users#edit_account', as: 'edit_account'
  delete '/users/:id', to: 'users#destroy', as: 'unsubscribe'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
