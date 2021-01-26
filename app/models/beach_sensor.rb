class BeachSensor < ApplicationRecord
  enum sensor_type: [:agua, :personas, :uv, :bandera]
  belongs_to :service_group

  after_create :provide_sensor_to_orion

  before_destroy :remove_sensor_from_orion

  def generate_and_send_data(ticks)
    return unless alive

    if should_send_data(ticks)
      reading = generate_data
      send_data(reading)
    end
  end

  def generate_people_and_send_data(ticks, current_people, beach_capacity)
    return 0 unless alive
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
      return ticks % period == 0
    elsif sensor_type == "personas"
      return ticks % period == 0
    elsif sensor_type == "uv"
      return ticks % period == 0
    else
      return ticks % period == 0
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
      value: data.to_s
    }

    OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_NORTH_URL']}/iot/json?k=#{ENV['ORION_API_KEY']}&i=Device#{id.to_s}", payload)
  end

  def provide_sensor_to_orion
    long_lat_match = location.to_s.match /(-?[0-9]*\.[0-9]* -?[0-9]*\.[0-9]*)/
    lon, lat = long_lat_match[0].split

    controlledProperty = {
      personas: "occupancy",
      uv: "solarRadiation",
      agua: "waterPollution",
      bandera: "weatherConditions"
    }

    payload = {
      devices: [
        {
          device_id: "Device#{id.to_s}",
          entity_name: "urn:ngsi-ld:Device:#{id}",
          entity_type: 'Device',
          static_attributes: [
            { name: "simulator_id", type: "Text", value: id.to_s },
            { name: "location", type: "geo:point", value: "#{lon}, #{lat}"},
            { name: "controlledAsset", type: "Text", value: beach_id.to_s },
            { name: "category", type: "Text", value: "sensor" },
            { name: "controlledProperty", type: "Text", value: "#{controlledProperty[sensor_type.to_sym]}" }
          ],
          attributes: [
            { object_id: "value", name: "value", type: "Text" }
          ]
        }
      ]
    }

    response = OrionHelper.make_orion_post_request("#{ENV['IOT_AGENT_SOUTH_URL']}/iot/devices", payload)
  end

  def remove_sensor_from_orion
    OrionHelper.delete_entity(self.id, true)
  end
end
