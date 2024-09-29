Rails.application.routes.draw do
  devise_for :users

  resources :events
  get 'my_events', to: 'events#my_events', as: 'my_events'
  root "home#index"
end
