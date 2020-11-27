class ServiceGroup < ApplicationRecord
  has_many :beach_sensors, dependent: :destroy
  has_many :bus_sensors, dependent: :destroy
end
