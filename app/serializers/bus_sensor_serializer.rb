require "geocoder"

class BusSensorSerializer < ActiveModel::Serializer

  attributes :id, :line, :subline, :direction, :alive

  def location
    Geocoder.encode(object.location)
  end
end
