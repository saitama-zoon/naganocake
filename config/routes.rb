Rails.application.routes.draw do

  devise_for :customers

  devise_for :admins, controllers: {
    sessions: 'sessions'
  }
  #root 'homes#top'
  root 'customers/homes#top'

  #namespace :customers do
    #get 'home' => "homes#home",as: 'home'
    resources :orders, only:[:new, :create, :index, :show]
    #get "orders/confirm" => "orders#confirm",as: "confirm"
    post "orders/confirm" => "customers/orders#confirm",as: "confirm"
    get "orders/thank" => "customers/orders#thank",as: "thank"
    post "orders/session" => "customers/orders#session",as: "session"
  #end

  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :categories, only: [:index, :edit, :create, :update]
    get 'home' => "homes#home",as: 'home'
  end
end