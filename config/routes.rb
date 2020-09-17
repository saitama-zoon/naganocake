Rails.application.routes.draw do
  devise_for :customers
<<<<<<< Updated upstream
  devise_for :admins
=======
  devise_for :admins, controllers: {
  	sessions: 'admin/sessions'
  }
    resources :categories, only: [:index, :edit, :create, :update]
>>>>>>> Stashed changes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end