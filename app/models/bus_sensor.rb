class BusSensor < ApplicationRecord
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  before_destroy :remove_sensor_from_orion

  def send_data
    return unless alive

    current_location = next_location
    payload = { location: "#{current_location[0]}, #{current_location[1]}" }

    OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_NORTH_URL']}/iot/json?k=#{ENV['ORION_API_KEY']}&i=Vehicle#{id.to_s}", payload)
  end

  def location
    detour = Detour.find_by(line: self.line, subline: self.subline, direction: self.direction, location_index: self.location_index)
    location = detour.location
    Geocoder.encode(location)
  end

  private

  def next_location
    detour = Detour.find_by(line: line, subline: subline, direction: direction, location_index: location_index)
    if detour
      self.location_index = self.location_index + 1
    else
      detour = Detour.find_by(line: line, subline: subline, direction: direction, location_index: 0)
      self.location_index = 1
    end
    self.save

    long_lat_match = detour&.location.to_s.match /(-?[0-9]*\.[0-9]* -?[0-9]*\.[0-9]*)/
    long_lat_match[0].split
  end

  def provide_sensor_to_orion
    degrees = subline == 'A' ? 0 : 180
    payload = {
      devices: [
        {
          device_id: "Vehicle#{id.to_s}",
          entity_name: "urn:ngsi-ld:Vehicle:#{id}",
          entity_type: 'Vehicle',
          static_attributes: [
            { name: "vehicleType", type: "Text", value: "bus" },
            { name: "category", type: "Text", value: "public" },
            { name: "heading", type: "Integer", value: degrees },
            { name: "fleetVehicleId", type: "Text", value: "#{line}-#{subline}-#{id}" },
            { name: "serviceProvided", type: "Text", value: "urbanTransit" },
            { name: "areaServed", type: "Text", value: "Montevideo" },
            { name: "serviceStatus", type: "Text", value: "onRoute" }
          ],
          attributes: [
            { object_id: 'location', name: 'location', type: 'geo:point' }
          ]
        }
      ]
    }

    response = OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/devices", payload)
  end

  def remove_sensor_from_orion
    OrionHelper.delete_entity(self.id, false)
  end
end
