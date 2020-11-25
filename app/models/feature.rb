
class Feature < ApplicationRecord
  self.primary_key = 'gid'

  class << self
    def create_by_type(type, params)
      feature_subclass(type).create(params)
    end

    def update_by_type(type, params)
      feature_subclass(type).update(params)
    end

    private

    def feature_subclass(type)
      case type
      when "sensor_uv"
        SensorUv
      when "sensor_banderas"
        SensorBandera
      when "sensor_personas"
        SensorPersona
      when "sensor_agua"
        SensorAgua
      when "playa"
        Playa
      end
    end
  end
end
