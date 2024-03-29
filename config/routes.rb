Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'user/travellers/dashboard', to: 'bookings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :activities, only: [:new, :create, :index, :show, :edit, :destroy] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show, :edit, :destroy] do
    member do
      patch "/accept", to: "bookings#accept"
      patch "/reject", to: "bookings#reject"
    end
  end
  get "guide_dashboard", to: "users#guide_dashboard", as: :guide_dashboard
  # temporaire to delete ci dessous
  get 'user/travellers/dashboard', to: 'bookings#index'

  get "myactivities", to: "activities#myactivities"

  get "traveller_dashboard", to: "users#traveller_dashboard"
  patch "activities/:id", to: "activities#update"
end
