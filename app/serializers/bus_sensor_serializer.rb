include ::Geo::Coder

class BusSensorSerializer < ActiveModel::Serializer

  attributes :id, :line, :subline, :direction, :location, :alive

  def location
    encode(object.location)
  end
end
