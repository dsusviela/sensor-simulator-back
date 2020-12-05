include ::Geo::Coder

class BusSensorSerializer < ActiveModel::Serializer
  attributes :id, :line, :subline, :direction, :location_index, :alive
end
