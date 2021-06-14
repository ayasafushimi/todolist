Rails.application.routes.draw do
  root 'todos#index'
  resources :todos
  # root "articles#new"
  patch '/todos/:id/done', to: 'todos#done', as: :done

  # get '/articles', to: 'articles#new'
  # post '/articles', to: 'articles#create'
  # get '/articles/:id', to: 'articles#done', as: :done
  # get '/articles/search', to: 'articles#search', as: :search
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
