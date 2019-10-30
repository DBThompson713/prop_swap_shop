Rails.application.routes.draw do
  resources :profiles
  devise_for :users, controllers: { registrations: "registrations" }
  resources :plants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root :to => “pages#home”


  get "/", to: "pages#home", as: "root"
  # get "/plants", to: "plants#index", as: "plants"
  # post "/plants", to: "plants#create"
  # get "/plants/new", to: "plants#new", as: "new_plant"
  # get "/plants/:id", to: "plants#show", as: "plant"
  # patch "/plants/:id", to: "plants#update"
  # get "/plants/:id/edit", to: "plants#edit", as: "edit_plant"
  # get "/payment/success", to: "payments#success", as: "success_payment" 
  # post "/payment/webhook", to:"payments#webhook", as: "webhook_payment"
end
