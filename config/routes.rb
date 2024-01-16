Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "home#index"

  get "home", to: "home#index"

  post "/submit", to: "contact#submit"

  get '/contact', to: 'contact#index'

  get '/contact', to: 'contact#contact'

  post '/submit', to: 'contact#submit', as: 'submit_contact'

end
