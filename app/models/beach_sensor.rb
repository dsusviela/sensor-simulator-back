class BeachSensor < ApplicationRecord
  enum type: [:agua, :personas, :uv, :bandera]
end
