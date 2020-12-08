module ServiceGroupHelper
  def self.get_or_initialize_service_group(is_beach)
    ServiceGroup.find_or_create_by(apikey: ENV['ORION_API_KEY'], is_beach: is_beach)
  end
end
