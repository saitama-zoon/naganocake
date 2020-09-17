Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins, controllers: {
  	sessions: 'sessions'
  }
  
  resources :orders, only:[:new, :create, :index, :show]
  get "orders/confirm" => "orders#confirm",as: "confirm"
  get "orders/thank" => "orders#thank",as: "thank"
  post "orders/session" => "orders#session",as: "session"
  
  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :categories, only: [:index, :edit, :create, :update]
    get 'home' => "homes#home",as: 'home'
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html