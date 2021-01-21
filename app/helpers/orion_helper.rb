require 'net/http'
require 'uri'
require 'json'

module OrionHelper
  HEADERS = { 'Content-Type': 'application/json', 'fiware-service': 'openiot', 'fiware-servicepath': '/' }.freeze
  ORION_HEADERS = { 'fiware-service': 'openiot', 'fiware-servicepath': '/' }.freeze

  def self.make_orion_post_request(endpoint, payload)
    uri = URI.parse(endpoint)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, HEADERS)
    request.body = payload.to_json

    http.request(request)
  end

  def self.delete_entity(id, is_beach)
    iot_agent_id = is_beach ? "Device#{id}" : "Vehicle#{id}"
    uri = URI.parse("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/devices/#{iot_agent_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Delete.new(uri.request_uri, HEADERS)
    http.request(request)

    orion_id = is_beach ? "urn:ngsi-ld:Device:#{id}" : "urn:ngsi-ld:Vehicle:#{id}"
    uri = URI.parse("#{ENV['CONTEXT_BROKER_URL']}/v2/entities/#{orion_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Delete.new(uri.request_uri, ORION_HEADERS)
    http.request(request)
  end
end
