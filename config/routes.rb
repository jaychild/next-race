Rails.application.routes.draw do
  resources :next_race

  root to: 'next_race#index'
end
