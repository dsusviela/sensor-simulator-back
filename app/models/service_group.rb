require 'net/http'
require 'uri'
require 'json'

class ServiceGroup < ApplicationRecord
  has_many :beach_sensors, dependent: :destroy
  has_many :bus_sensors, dependent: :destroy

  after_create :provide_service_group_to_orion

  private

  def provide_service_group_to_orion
    type = is_beach? ? "Device" : "Vehicle"
    resource = is_beach? ? "/iot/beaches" : "/iot/buses"
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
end
