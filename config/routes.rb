Rails.application.routes.draw do
  resources :simulator_processes
  resources :bus_sensors
  resources :beach_sensors

  delete '/beach_sensors/', to: 'beach_sensors#delete_all'
  delete '/bus_sensors/', to: 'bus_sensors#delete_all'
  post "beach_sensors/preload_data", to: "beach_sensors#preload_data"
  post "bus_sensors/preload_data", to: "bus_sensors#preload_data"
end
