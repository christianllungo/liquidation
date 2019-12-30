Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  resources :users, only: [:new, :create, :show, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
end
