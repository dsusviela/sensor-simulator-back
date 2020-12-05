class BusSensor < ApplicationRecord
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  def send_data
    return unless alive

    payload = { location: "#{next_location[0]}, #{next_location[1]}" }

    update_location_index_value

    OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_NORTH_URL']}/iot/json?k=#{ENV['ORION_API_KEY']}&i=Device#{id.to_s}", payload)
  end

  private

  def next_location
    detour = Detour.where(line: line, subline: subline, direction: direction, location_index: location_index)&.first

    long_lat_match = detour&.location.to_s.match /(-?[0-9]*\.[0-9]* -?[0-9]*\.[0-9]*)/
    lon, lat = long_lat_match[0].split

    [lon, lat]
  end

  def update_location_index_value
    current_index = location_index

    self.update(location_index: current_index + 1)
  end

  def provide_sensor_to_orion
    payload = {
      devices: [
        {
          device_id: "Vehicle#{id.to_s}",
          entity_name: "urn:ngsi-ld:Vehicle:#{id}",
          entity_type: 'Vehicle',
          static_attributes: [
            { name: "linea", type: "Text", value: line },
            { name: "sublinea", type: "Text", value: subline },
            { name: "sentido", type: "Text", value: direction }
          ],
          attributes: [
            { object_id: 'location', name: 'location', type: 'geo:point' }
          ]
        }
      ]
    }

    response = OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/devices", payload)
  end
end
