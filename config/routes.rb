Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "posts/confirm", to: "posts#confirm", as: "confirm_post"
  get "posts/:id/delete", to: "posts#delete", as: "delete_post"
  get "search", to: "search#index", as: "search"

  root 'top#index'
  resources :posts


end
