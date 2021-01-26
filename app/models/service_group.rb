require 'net/http'
require 'uri'
require 'json'

class ServiceGroup < ApplicationRecord
  has_many :beach_sensors, dependent: :destroy
  has_many :bus_sensors, dependent: :destroy

  after_create :provide_service_group_to_orion, :suscribe_pygeoapi_to_orion

  private

  def provide_service_group_to_orion
    type = is_beach? ? "Device" : "Vehicle"
    resource = "/iot/json"
    payload = {
      services: [
        {
          apikey: apikey,
          cbroker: ENV["CONTEXT_BROKER_URL"],
          entity_type: "#{type}",
          resource: resource
        }
      ]
    }
    OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/services", payload)
  end

  def suscribe_pygeoapi_to_orion
    description, suscription_type, notification_attributes, sensor_attributes = get_suscription_data
    target_endpoint = is_beach? ? "beach-sensor-update" : "detour"
    payload = {
      description: description,
      subject: {
        entities: [{ "idPattern": "#{suscription_type}.*","type": suscription_type }],
        condition: {
          attrs: notification_attributes
        }
      },
      notification: {
        httpCustom: {
          url: "http://pygeoapi:5000/processes/#{target_endpoint}/jobs",
          headers: {
            'Content-Type': "application/json"
          },
          method: "POST",
          payload: encode_to_json_string(sensor_attributes)
        },
        attrs: sensor_attributes,
        attrsFormat: "keyValues",
        metadata: ["dateCreated", "dateModified"]
      },
      throttling: 0
    }

    response = OrionHelper.make_orion_post_request("#{ENV['CONTEXT_BROKER_URL']}/v2/subscriptions/", payload)
  end

  def get_suscription_data
    description = "Notify pygeoapi of changes in a bus location value"
    suscription_type = "Vehicle"
    notification_attributes = ["location"]
    sensor_attributes = ["heading", "fleetVehicleId", "location"]

    if is_beach?
      description = "Notify pygeoapi of changes in a beach sensor value"
      suscription_type = "Device"
      notification_attributes = ["value"]
      sensor_attributes = ["simulator_id", "location", "controlledAsset", "controlledProperty", "value"]
    end

    [description, suscription_type, notification_attributes, sensor_attributes]
  end

  def encode_to_json_string(attributes)
    res = "{%22inputs%22%3A%5B"
    attributes.each do |attribute|
      object_string = "%7B"
      object_string += "%22id%22%3A%22#{attribute}%22%2C"

      object_string += "%22value%22%3A%22${#{attribute}}%22%2C"

      object_string += "%22type%22%3A%22text%2Fplain%22"

      object_string += "%7D"

      res += object_string + "%2C"
    end
    res = res.delete_suffix('%2C')
    res += "%5D}"
    res
  end
end
