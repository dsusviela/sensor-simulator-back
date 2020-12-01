include ::Geo::Coder

class BeachSensorSerializer < ActiveModel::Serializer

  attributes :id, :sensor_type, :location, :ngsi_device_id, :ngsi_entity_name, :ngsi_entity_type, :random_ceil, :random_floor, :random_seed, :random_std_dev, :alive, :fixed, :fixed_value

  def location
    encode(object.location)
  end
end
