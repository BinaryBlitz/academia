Rails.application.routes.draw do
  devise_for :admins, path: 'admin', skip: :registrations
  get 'admin', to: 'admin/orders#index'

  namespace :admin do
    resources :badges, except: :show
    resources :categories, except: [:show] do
      resources :dishes, shallow: true
    end
    resources :users, except: [:new, :create]
    resources :promo_codes, except: [:show]
    resources :working_hours, except: [:show, :edit, :update]
    resources :edge_points, except: [:show, :edit, :update]
    resources :couriers
    resources :analytics, only: [:index]
    resources :reviews, only: [:index]
    resources :delivery_points, except: [:show, :edit, :update]
    resources :exports, only: [:new, :create]
    resources :orders, except: [:new, :create]
    resource :welcome_screen, controller: 'welcome_screen', only: [:show, :update]
  end

  scope module: 'courier' do
    resource :courier, only: [:update] do
      post 'authenticate', on: :collection
      resources :orders, only: [:index, :update] do
        get 'assigned', on: :collection
        patch 'assign', on: :member
      end
    end
  end

  namespace :api do
    resource :user, only: [:show, :create, :update]
    resources :verification_tokens, only: [:create, :update], param: :token

    resources :categories, only: [:index] do
      resources :dishes, only: [:index]
    end

    resource :store, only: :show, controller: :store
    resources :working_hours, only: :index

    resources :payment_cards, only: [:index, :create]

    resources :orders, except: [:new, :edit] do
      resources :payments, only: [:create]
      member do
        post 'payment'
      end
    end
    resources :edge_points, only: :index
    post 'promo_codes/redeem'
  end

  resources :payments, only: [] do
    get 'status', 'success', 'failure', on: :collection
  end
end
