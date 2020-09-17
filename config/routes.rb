Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins

  resource :orders, only:[:new, :create, :index, :show]
    namespace :admins do
      resource :orders, only:[:index, :show, :update]
  end

  get "orders/confirm" => "orders#confirm"
  get "orders/thank" => "orders#thank",as: "thank"
  post "orders/session" => "orders#session",as: "session"
end
