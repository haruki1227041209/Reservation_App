Rails.application.routes.draw do
  
  root 'rooms#index_toppage'
  get '/toppage', to: 'rooms#index_toppage', as: 'toppage'
  
  resources :users do
    get '/signup', to: 'users#new', on: :collection
    post '/signup', to: 'users#create', on: :collection

    member do
      get 'show_profile', as: 'show_profile'
      get 'show_account', as: 'show_account'
      get 'edit_profile', as: 'edit_profile'
      patch 'update_profile', as: 'update_profile'
      get 'edit_account', as: 'edit_account'
      patch 'update_account', as: 'update_account'
      delete '/', to: 'users#destroy', as: 'unsubscribe'
    end
    
    resources :rooms do
      get 'index_room', on: :member, as: 'index_user_room'
      get 'new_room', on: :collection
      
      get 'search', on: :member, as: 'search_rooms'

      resources :reservations do
        get 'index_reservation', on: :collection, as: 'index_user_reservation'
        get 'new_reservation', on: :collection
        get 'confirm', on: :collection, as: 'confirm_user_reservation'
        post 'confirm', to: 'reservations#confirm_create', on: :collection
      end
    end
  end
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/users/:user_id/rooms/new', to: 'rooms#create'
  get '/reservations/index', to: 'reservations#index', as: 'reservations_index'
  post '/users/:user_id/rooms/:room_id/reservations/new', to: 'reservations#create'

  resources :rooms
  get '/search', to: 'rooms#search', as: 'search_rooms'
end
