require 'json'

GEOJSON_FILES_DIR = "../detours_geojsons".freeze

geojson_files = Dir.entries(GEOJSON_FILES_DIR)

geojson_files.each do |geojson_file_name|
  line, direction, subline = geojson_file_name.split("_")

  location_index = 0
  geojson_file_hash = JSON.parse(file)

  geojson_file_hash["features"].each do |feature|
    params = {}
    params[:line] = line
    params[:direction] = direction
    params[:subline] = subline
    params[:location_index] = location_index

    # puede que sea al reves
    lon = feature["geometry"]["coordinates"][0]
    lat = feature["geometry"]["coordinates"][1]

    params[:location] = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)
    Detour.create!(params)

    location_index += 1
  end
end
