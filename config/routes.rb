Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "home#index"

  resources :home, only: [:index]

  get '/contact', to: 'contact#index'
  post '/submit', to: 'contact#submit', as: 'submit_contact'
end
