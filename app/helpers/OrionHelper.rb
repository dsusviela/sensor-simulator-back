require 'net/http'
require 'uri'
require 'json'

module OrionHelper
  HEADERS = { 'Content-Type': 'application/json', 'fiware-service': 'openiot', 'fiware-servicepath': '/' }.freeze

  def self.make_orion_post_request(endpoint, payload)
    uri = URI.parse(endpoint)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, HEADERS)
    request.body = payload.to_json

    http.request(request)
  end
end
