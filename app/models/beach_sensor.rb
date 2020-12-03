class BeachSensor < ApplicationRecord
  enum sensor_type: [:agua, :personas, :uv, :bandera]
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  def generate_and_send_data(ticks)
    return unless alive

    if should_send_data(ticks)
      reading = generate_data
      send_data(reading)
    end
  end

  def generate_people_and_send_data(ticks, current_people, beach_capacity)
    return unless alive
    reading = 0
    if should_send_data(ticks)
      reading = generate_people_data(ticks, current_people, beach_capacity)
      send_data(reading)
    end
    reading
  end

  private

  def should_send_data(ticks)
    if sensor_type == "agua"
      return ticks % 2 == 0
    elsif sensor_type == "personas"
      return ticks % 1 == 0
    elsif sensor_type == "uv"
      return ticks % 5 == 0
    else
      return ticks % 3 == 0
    end
  end

  def generate_data
    return fixed_value if fixed

    raise 'sth went wrong; maxrange < minrange' if random_ceil < random_floor

    rand(random_floor..random_ceil)
  end

  def generate_people_data(ticks, current_people, beach_capacity)
    adjust_floor_and_ceil(ticks)

    reading = rand(random_floor..random_ceil)

    adjust_to_comply_params(reading, current_people, beach_capacity)
  end

  def adjust_floor_and_ceil(ticks)
    @max_growth = 10
    @stagnation = 15
    @max_decline = 20

    if ticks < @max_growth
      random_floor = 0
      random_ceil = 5
    elsif @max_growth <= ticks && ticks <= @stagnation
      random_floor = -1
      random_ceil = 10
    elsif @stagnation <= ticks && ticks <= @max_decline
      random_floor = -3
      random_ceil = 4
    elsif @max_decline <= ticks
      random_floor = -10
      random_ceil = 1
    end
    self.save
  end

  def adjust_to_comply_params(reading, current_people, beach_capacity)
    if beach_capacity < current_people + reading || current_people + reading < 0
      reading = 0
    end
    reading
  end

  def send_data(data)
    payload = {
      value: data
    }

    OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_NORTH_URL']}/iot/json?k=#{ENV['ORION_API_KEY']}&i=Device#{id.to_s}", payload)
  end

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

  def generate_data_with_gauss
    return fixed_value if fixed

    raise 'sth went wrong; maxrange < minrange' if random_ceil < random_floor

    math_helper = MathsHelper.new
    mean = math_helper.mean((random_floor..random_ceil).to_a)
    std = random_std_dev.present? ? random_std_dev : 1
    math_helper.initialize_gaussian(mean, std)

    valid = false
    current_reading = 0
    while !valid do
      current_reading = math_helper.rand.round
      valid = random_floor <= current_reading && current_reading <= random_ceil
    end
    current_reading
  end
end
