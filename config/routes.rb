Foodwithus::Application.routes.draw do
  resources :groups

  get '/login', :to => 'sessions#new', :as => 'login'
  get '/logout', :to => 'sessions#destroy', :as => 'logout'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  get '/about', to: 'pages#about'
  get '/privacy', to: 'pages#privacy'

  root :to => 'groups#index'
end
