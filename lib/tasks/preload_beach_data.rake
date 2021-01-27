
require "geocoder"
require "find"

namespace :beach do
  desc 'preload beach data'
  task :preload_data => :environment do
    BEACH_DATA_FOLDER = "#{Rails.root}/public/beach_geojson/".freeze
    RANGES_BY_TYPE = {
      "uv" => {
        "ceil" => 11,
        "floor" => 1,
        "std_dev" => 2,
        "period" => 1
      },
      "personas" => {
        "ceil" => 10,
        "floor" => 0,
        "std_dev" => 2,
        "period" => 1
      },
      "bandera" => {
        "ceil" => 2,
        "floor" => 0,
        "std_dev" => 2,
        "period" => 1
      },
      "agua" => {
        "ceil" => 1,
        "floor" => 0,
        "std_dev" => 2,
        "period" => 1
      }
    }.freeze

    service_group = ServiceGroupHelper.get_or_initialize_service_group(true)
    count = 0
    Find.find(BEACH_DATA_FOLDER) do |path|
      next if File.directory?(path)

      file = File.read(path)
      data_hash = JSON.parse(file)

      sensor_type = File.basename(path, ".json").match(/sensores_(\w+)\Z/)[1]

      data_hash["features"].each do |feature|
        count += 1

        coords = feature["geometry"]["coordinates"]
        point = Geocoder.point(coords)
        props = feature["properties"]

        BeachSensor.find_or_create_by(
          sensor_type: sensor_type,
          location: point,
          random_ceil: RANGES_BY_TYPE[sensor_type]["ceil"],
          random_floor: RANGES_BY_TYPE[sensor_type]["floor"],
          random_seed: 1,
          alive: true,
          fixed: false,
          beach_id: props["id_playa"],
          service_group_id: service_group.id,
          period: RANGES_BY_TYPE[sensor_type]["period"]
        )
      end

      Find.prune
    end
  end
end

