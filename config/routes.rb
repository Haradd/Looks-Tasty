Rails.application.routes.draw do
  resources :recipes

  root to: 'home#index'

  get '/about' => 'home#about', as: 'about'

  get '/contact' => 'home#contact', as: 'contact'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
