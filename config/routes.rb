Rails.application.routes.draw do
  get 'reservations/index'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id/show_profile', to: 'users#show_profile', as: 'show_profile'
  get '/users/:id/show_account', to: 'users#show_account', as: 'show_account'

  get '/users/:id/edit_profile', to: 'users#edit_profile', as: 'edit_profile'
  patch '/users/:id/update_profile', to: 'users#update_profile', as: 'update_profile'
  
  get '/users/:id/edit_account', to: 'users#edit_account', as: 'edit_account'
  patch '/users/:id/update_account', to: 'users#update_account', as: 'update_account'

  delete '/users/:id', to: 'users#destroy', as: 'unsubscribe'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :rooms
  get '/users/:id/index_room', to: 'rooms#index', as: 'index_user_room'
  get '/users/:id/new_room', to: 'rooms#new', as: 'new_user_room'
  post '/users/:id/new_room', to: 'rooms#create'
  get '/users/:user_id/rooms/:id', to: 'rooms#show', as: 'user_room'
  get '/toppage', to: 'rooms#index_toppage', as: 'toppage'
  get '/search', to: 'rooms#search', as: 'search_rooms'

  resources :reservations
  get 'index_reservation', to: 'reservations#index', as: 'index_user_reservation'
  get '/users/:user_id/rooms/:room_id/new_reservation', to: 'reservations#new', as: 'new_user_reservation' # 入力画面
  post '/users/:user_id/rooms/:room_id/new_reservation', to: 'reservations#create'
  get '/reservation/confirm', to: 'reservations#confirm', as: 'confirm_user_reservation' # 確認画面
  post '/reservation/confirm', to: 'reservations#confirm_create'
end
