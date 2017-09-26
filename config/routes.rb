Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :recipes
    end
  end
  root to: 'recipes#index'

  devise_scope :user do
      get 'users/recipes' => 'users#recipes'
      get 'users/finish_sign_up' => 'users#finish_oauth_sign_up'
      post 'users/finish_sign_up' => 'users#configure_profile'
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'users/registrations' }
  resources :recipes do
    resources :reviews
  end

  get '/about' => 'home#about', as: 'about'

  get '/contact' => 'home#contact', as: 'contact'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
