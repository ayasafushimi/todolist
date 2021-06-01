Rails.application.routes.draw do
  root "articles#new"

  get '/articles', to: 'articles#new'
  post '/articles', to: 'articles#create'
  get '/articles/:id', to: 'articles#done', as: :done
  get '/articles/search', to: 'articles#search', as: :search
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
