class BeachSensor < ApplicationRecord
  enum sensor_type: [:agua, :personas, :uv, :bandera]
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  private

  def provide_sensor_to_orion
    long_lat_match = location.to_s.match /(-?[0-9]*\.[0-9]* -?[0-9]*\.[0-9]*)/
    lon, lat = long_lat_match[0].split
    payload = {
      devices: [
        {
          device_id: "Device#{id.to_s}",
          entity_name: "urn:ngsi-ld:Device:#{id}",
          entity_type: 'Device',
          static_attributes: [
            { name: "simulator_id", type: "Text", value: id.to_s },
            { name: "location", type: "geo:point", value: "#{lon}, #{lat}"},
            { name: "beach_id", type: "Text", value: beach_id.to_s },
            { name: "sensor_type", type: "Text", value: sensor_type.to_s }
          ],
          attributes: [
            { object_id: "value", name: "value", type: "Text" }
          ]
        }
      ]
    }

    response = OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/devices", payload)
  end
end
