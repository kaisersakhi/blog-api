Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/swagger'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :authors, only: %i[show update]

  resources :articles, only: %i[index show update create destroy]

  post "/register", to: "authors#create"
  post "/login", to: "authors#login"
  delete "/logout", to: "authors#logout"
end
