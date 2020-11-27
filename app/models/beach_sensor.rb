class BeachSensor < ApplicationRecord
  enum sensor_type: [:agua, :personas, :uv, :bandera]
end
