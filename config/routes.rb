Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get('/', {to:'posts#index', as: 'root'})

  get('/users/panel', {to: 'users#panel', as: 'users_panel'})
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]
end
