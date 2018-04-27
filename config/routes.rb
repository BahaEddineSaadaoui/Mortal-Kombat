Rails.application.routes.draw do
  resources :progressweapons
  resources :fights
  resources :photos
  resources :weapons
  resources :progresses
  resources :fighters
  get 'prepare' => 'front#prepare'
  post 'arena' => 'front#arena'
  get 'arena' => "front#index"
  root to: "front#index"
end
