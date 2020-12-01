Rails.application.routes.draw do
  resources :simulator_processes
  resources :bus_sensors
  resources :beach_sensors
end
