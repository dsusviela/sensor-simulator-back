class BusSensor < ApplicationRecord
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  private

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
