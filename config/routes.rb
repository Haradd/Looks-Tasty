Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :recipes

  root to: 'recipes#index'

  get '/about' => 'home#about', as: 'about'

  get '/contact' => 'home#contact', as: 'contact'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
