
require "geocoder"
require "find"

namespace :bus do
  desc 'preload bus data'
  task :preload_data => :environment do
    BUS_DATA_FOLDER = "#{Rails.root}/db/detours_geojsons/".freeze
    service_group = ServiceGroupHelper.get_or_initialize_service_group(true)

    Find.find(BUS_DATA_FOLDER) do |path|
      next if File.directory?(path)

      file_name = File.basename(path, ".geojson")
      match = file_name.match(/(\d*)_(\w)_(\d)/)

      BusSensor.create!(
        line: match[1],
        direction: match[2],
        subline: match[3],
        location_index: 0,
        alive: true,
        service_group_id: service_group.id
      )

      puts "Creted bus with #{match[1]}, #{match[2]}, #{match[3]}"
      Find.prune
    end
  end
end

