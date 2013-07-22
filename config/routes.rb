YatayWeb::Application.routes.draw do
  devise_for :users do 
    get "/", :to => "devise/sessions#new"
    get "/users/sign_up", :to => "devise/sessions#new"
  end
  
  resources :certificates
  resources :receipts
  resources :clients
  
  namespace :admin do
    resources :users, :except => [:show]
  end
  
  root :to => "devise/sessions#new"
end
