Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions', registrations: 'customers/registrations', passwords: 'customers/passwords'
  }
  devise_for :admins, controllers: {
  	sessions: 'sessions'
  }
  
  root 'customers/homes#top'
  

    get 'home' => "customers/homes#top",as: 'home'
    get 'homes/about' => "customers/homes#about",as: 'about'
    resources :orders, only: [:new, :create, :index, :show]
    get "orders/confirm" => "customers/orders#confirm",as: "confirm"
    get "orders/thank" => "customers/orders#thank",as: "thank"
    post "orders/session" => "customers/orders#session_a",as: "session"


  devise_scope :customers do
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customers_session'
  end

  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :categories, only: [:index, :edit, :create, :update]
    get 'home' => "homes#home",as: 'home'
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html