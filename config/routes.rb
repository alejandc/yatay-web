YatayWeb::Application.routes.draw do
  resources :receipts
 
  root to: "receipts#index"
end
