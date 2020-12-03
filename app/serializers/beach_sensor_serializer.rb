include ::Geo::Coder

class BeachSensorSerializer < ActiveModel::Serializer

  attributes :id, :sensor_type, :location, :random_ceil, :random_floor, :random_seed, :random_std_dev, :alive, :fixed, :fixed_value

  def location
    encode(object.location)
  end
end
