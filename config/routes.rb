School::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'
  get "analytics" => "analytics#index"
  resources :users
  resources :tests do
    collection do
      get :practice
    end
  end
  resources :clozes
  resources :reviews, :only => [:index]
  resources :points, :only => [:show, :edit, :update]
  resources :choices, :only => [:index, :create]
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
