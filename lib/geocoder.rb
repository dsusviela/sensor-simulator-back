module Geocoder
  class << self
    def encode(feature)
      geojson_decoder.encode(feature)
    end

    def point(coords)
      geo_factory(ENV['SRID']).point(coords[0], coords[1])
    end

    private

    def geojson_decoder
      @geojson_decoder ||= RGeo::GeoJSON::Coder.new(geo_factory: geo_factory(ENV['SRID']))
    end

    def geo_factory(srid)
      @geo_factory ||= RGeo::Geographic.spherical_factory(srid: srid)
    end
  end
end
