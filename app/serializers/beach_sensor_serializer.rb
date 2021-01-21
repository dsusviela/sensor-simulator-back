require "geocoder"

class BeachSensorSerializer < ActiveModel::Serializer

  attributes :id, :sensor_type, :location, :random_ceil, :random_floor, :random_seed, :alive, :fixed, :fixed_value, :beach_id

  def location
    Geocoder.encode(object.location)
  end
end
