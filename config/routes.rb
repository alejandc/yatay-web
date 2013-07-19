YatayWeb::Application.routes.draw do
  devise_for :users do 
    get "/", :to => "devise/sessions#new"
    get "/users/sign_up", :to => "devise/sessions#new"
  end
  
  resources :admin, :only => [:index]
  namespace :admin do
    resources :users, :except => [:show]
  end
  resources :receipts
  
  root :to => "devise/sessions#new"
end
