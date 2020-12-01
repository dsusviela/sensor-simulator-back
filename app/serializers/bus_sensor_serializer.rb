include ::Geo::Coder

class BusSensorSerializer < ActiveModel::Serializer

  attributes :id, :line, :subline, :direction, :location, :ngsi_device_id, :ngsi_entity_name, :ngsi_entity_type, :alive

  def location
    encode(object.location)
  end
end
