module Geo::Coder
  def encode(feature)
    geojson_decoder.encode(feature)
  end

  private

  def geojson_decoder
    @geojson_decoder ||= RGeo::GeoJSON::Coder.new(geo_factory: geo_factory(4326))
  end

  def geo_factory(srid)
    @geo_factory ||= RGeo::Geographic.spherical_factory(srid: srid)
  end
end
