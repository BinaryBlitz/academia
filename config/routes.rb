Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins, path: 'admin', skip: :registrations
  get 'admin', to: 'admin/days#index'

  namespace :admin do
    resources :ingredients, except: :show
    resources :badges, except: :show
    resources :dishes
    resources :days
    resources :users, except: [:new, :create]
    resources :promo_codes, except: [:show]
    resources :working_hours, except: [:show, :edit, :update]
    resources :edge_points, except: [:show, :edit, :update]
    resources :couriers
    resources :alerts, only: [:index]
    resources :analytics, only: [:index]
    resources :delivery_points, except: [:show, :edit, :update]
    resources :orders do
      get 'delivered', 'rejected', 'on_the_way', on: :collection
    end

    get 'lunches' => 'dishes#lunches'
    get 'stuff' => 'dishes#stuff'

    get 'schedule' => 'days#index'
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

  resource :user, only: [:show, :create, :update]
  resources :verification_tokens, only: [:create, :update], param: :token

  resources :dishes, only: [:index] do
    get 'stuff', on: :collection
  end

  resource :day, only: :show

  resources :orders, except: [:new, :edit] do
    member do
      post 'payment'
      get 'payment_status'
    end
  end
  resources :edge_points, only: :index
  post 'promo_codes/redeem'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
