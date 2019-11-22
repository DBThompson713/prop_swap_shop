Rails.application.routes.draw do
  get 'messages/index'
  get 'conversations/index'
  resources :profiles
  devise_for :users, controllers: { registrations: "registrations" }
  resources :plants
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root :to => “pages#home”


  get "/", to: "pages#home", as: "root"

  
  get "/payment/success", to: "payments#success", as: "success_payment" 
  # post "/payment/webhook", to:"payments#webhook", as: "webhook_payment"


end
