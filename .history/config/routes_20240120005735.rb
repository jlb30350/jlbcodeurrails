Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :home, only: [:index]

  get "home", to: "home#index"

  get '/contact', to: 'contact#index'
  post '/submit', to: 'contact#submit', as: 'submit_contact'

  root "home#index"

end
