Rails.application.routes.draw do
  get 'contact', to: 'contact#index', as: 'contact'
  get 'about', to: 'about#index', as: 'about'
  get 'product/:id', to: 'product#show', as: 'show_product'

  root to: 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
