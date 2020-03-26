Rails.application.routes.draw do
  resources :okasis

  get "posts/" => "posts#index"
  post "posts/create" => "posts#create"
  delete "posts/:id/destroy" => "posts#destroy"

  get "users/new" => "users#new"
  get "/" => "users#login"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/logout" => "users#logout"
  post "users/authentication" => "users#authentication"
  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
