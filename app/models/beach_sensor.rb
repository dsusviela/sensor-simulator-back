class BeachSensor < ApplicationRecord
  enum sensor_type: [:agua, :personas, :uv, :bandera]
  belongs_to :service_group
end
