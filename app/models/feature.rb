
class Feature < ApplicationRecord
  self.primary_key = 'gid'

  class << self
    def find_by_type(type, id)
      feature_subclass(type).find(id)
    end

    def create_by_type(type, params)
      feature_subclass(type).create(params)
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
