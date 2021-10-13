Rails.application.routes.draw do
  root 'sessions#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'

  resources :pictures, only: [:index , :new, :create]

end
