Rails.application.routes.draw do
  resources :bus_sensors
  resources :beach_sensors

  post "beach_sensors/preload_data", to: "beach_sensors#preload_data"
end
