require 'json'

GEOJSON_FILES_DIR = "./db/detours_geojsons".freeze
GEOJSON_FILE_DIR = "./db/detours_geojsons/file_name"

geojson_file_names = Dir.entries(GEOJSON_FILES_DIR)

geojson_file_names.delete(".")
geojson_file_names.delete("..")

skipable_file_names = [".", "..", ".DS_Store"]

geojson_file_names.each do |geojson_file_name|
  next if skipable_file_names.include? geojson_file_name

  line, direction, subline = geojson_file_name.split("_")
  location_index = 0

  geojson_file_string = IO.read(GEOJSON_FILE_DIR.gsub("file_name", geojson_file_name))
  geojson_file_hash = JSON.parse(geojson_file_string)

  geojson_file_hash["features"].each do |feature|
    params = {}
    params[:line] = line
    params[:direction] = direction
    params[:subline] = subline.gsub(".geojson", "")
    params[:location_index] = location_index

    # capaz que es al reves
    lon = feature["geometry"]["coordinates"][0]
    lat = feature["geometry"]["coordinates"][1]

    params[:location] = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)
    Detour.create!(params)

    location_index += 1
  end
end
