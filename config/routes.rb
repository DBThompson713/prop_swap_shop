Rails.application.routes.draw do
  devise_for :users
  resources :plants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # home#index
end
