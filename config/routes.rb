Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'todos#index'
  resources :todos
  patch '/todos/:id/done', to: 'todos#done', as: :done

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
