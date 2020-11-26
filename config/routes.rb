Rails.application.routes.draw do
  resources :bus_sensors
  resources :beach_sensors
  resources :sensors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
