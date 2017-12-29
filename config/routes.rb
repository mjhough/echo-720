Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'  }
  root to: 'home#index'
    
  resources :subjects do
    resources :videos, except: %i(index)
  end
  resources :videos, only: %i(index)
  

end
