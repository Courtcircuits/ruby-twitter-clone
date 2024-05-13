Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "tweets#index"

  get "/tweets", to: "tweets#index"
  get "/tweet/:id", to: "tweets#show"
  post "/tweets", to: "tweets#create"

  get "/users", to: "users#index"
  get "/user/:id", to: "users#show"
  post "/signup", to: "users#create"
  post "/signin", to: "users#login"

  # Defines the root path route ("/")
  # root "posts#index"
end
