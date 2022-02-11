Rails.application.routes.draw do
  
  
  devise_for :customers, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }
  
  devise_for :admin, controllers: {
    sessions:       'admin/sessions',
    passwords:      'admin/passwords',
    registrations:  'admin/registrations'
  }
  
  # devise_scope :admin do
  #   get '/admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
  #   post '/admin/sign_in' => 'admin/sessions#create', as: :admin_session
  #   delete '/admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
  #   get '/admin/password/new' => 'admin/passwords#new', as: :new_admin_password
  #   get '/admin/password/edit' => 'admin/passwords#edit', as: :edit_admin_password
  #   patch '/admin/password' => 'admin/passwords#update', as: :admin_password
  #   put '/admin/password' => 'admin/passwords#update'
  #   post '/admin/cancel' => 'admin/passwords#create'
  #   get '/admin/cancel' => 'admin/registrations#cancel', as: :cancel_admin_registration
  #   get '/admin/sign_up' => 'admin/registrations#new', as: :new_admin_registration
  #   get '/admin/edit' => 'admin/registrations#edit', as: :edit_admin_registration
  #   patch '/admin' => 'admin/registrations#update', as: :admin_registration
  #   put '/admin' => 'admin/registrations#update'
  #   delete '/admin' => 'admin/registrations#destroy'
  #   post '/admin' => 'admin/registrations#create'
  #end
  
  
  scope module: :public do
    root :to => 'homes#top'
    get "/homes/about" =>"homes#about"
    resources :items, only:[:show, :index]
    resources :registrations, only:[:new, :create]
    
    get "customer", to: "customers#show"
    get "/customer/edit" => "customers#edit"
    patch "/customer/update" => "customers#update"
    get "/customer/confirm" => "customers#confirm"
    patch "/customer/renew" => "customers#renew"
  
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete "destroy_all",to: "cart_items#destroy_all"
      end
    end
    post "/orders/confirm", to: "orders#confirm"
    get "/orders/thanks", to: "orders#thanks"
    resources :orders, only:[:new, :create, :index, :show]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end
  
  # /admin/~のURLができる
  namespace :admin do
    root :to => 'homes#top'
    # resources :homes, only:[:top]
    post "/items/new" => "items#create"
    resources :items, only:[:new, :index, :show, :edit, :update]
    resources :genres, only:[:create, :index, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:edit, :update]
    resources :order_items, only:[:update]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
