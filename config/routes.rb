School::Application.routes.draw do


  root :to => 'sevgital#index'
  get "analytics" => "analytics#index"
  get 'home' => 'home#index'
  resources :users
  resources :tests do
    collection do
      get :practice
    end
  end
  resources :clozes
  resources :identities
  resources :reviews, :only => [:index]
  resources :points, :only => [:show, :edit, :update]
  resources :choices, :only => [:index, :create]
  match '/auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: 'sessions#failue'
  match '/logout' => 'sessions#destroy', :as => :signout
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
