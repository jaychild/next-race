Rails.application.routes.draw do
  resources :next_race

  resources :api_configuration

  root to: 'next_race#index'
end
