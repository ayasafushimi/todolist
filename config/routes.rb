Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      member do
        patch :confirm, action: :confirm
      end
      collection do
        post :confirm, action: :confirm
      end
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'todos#index'
  resources :todos do
    member do
      patch :confirm, action: :confirm
    end
    collection do
      post :confirm, action: :confirm
    end
  end
  patch '/todos/:id/done', to: 'todos#done', as: :done

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
