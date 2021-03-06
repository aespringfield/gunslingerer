Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "gunslingers#index"

  resources :gunslingers
  resources :badge_templates
  resources :recruits
end
