Rails.application.routes.draw do
  resources :progressweapons
  resources :fights
  resources :photos
  resources :weapons
  resources :progresses
  resources :fighters
  get 'arena' => 'front#arena'
  root to: "front#index"
end
