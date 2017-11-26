Rails.application.routes.draw do
  get 'invoice/index'

  get 'checkout', to: 'checkout#show', as: 'show_checkout'
  get 'cart', to: 'cart#show', as: 'show_cart'
  get 'contact', to: 'contact#index', as: 'contact'
  get 'about', to: 'about#index', as: 'about'
  get 'product/:id', to: 'product#show', as: 'show_product'

  root to: 'home#index'

  resources :home do
    member do
      post :add_product_to_cart
    end
  end

  resources :cart do
    member do
      post :delete_product_from_cart
    end

    collection do
      post :update_product_quantity
    end
  end

  resources :checkout do
    collection do
      post :save_address
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
