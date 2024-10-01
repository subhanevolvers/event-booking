# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :events
  resources :bookings
  get 'my_events', to: 'events#my_events', as: 'my_events'
  root 'home#index'
end
