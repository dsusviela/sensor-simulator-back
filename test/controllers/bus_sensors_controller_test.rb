require 'test_helper'

class BusSensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bus_sensor = bus_sensors(:one)
  end

  test "should get index" do
    get bus_sensors_url, as: :json
    assert_response :success
  end

  test "should create bus_sensor" do
    assert_difference('BusSensor.count') do
      post bus_sensors_url, params: { bus_sensor: { device_id: @bus_sensor.device_id, direction: @bus_sensor.direction, entity_name: @bus_sensor.entity_name, entity_type: @bus_sensor.entity_type, line: @bus_sensor.line, location: @bus_sensor.location, subline: @bus_sensor.subline } }, as: :json
    end

    assert_response 201
  end

  test "should show bus_sensor" do
    get bus_sensor_url(@bus_sensor), as: :json
    assert_response :success
  end

  test "should update bus_sensor" do
    patch bus_sensor_url(@bus_sensor), params: { bus_sensor: { device_id: @bus_sensor.device_id, direction: @bus_sensor.direction, entity_name: @bus_sensor.entity_name, entity_type: @bus_sensor.entity_type, line: @bus_sensor.line, location: @bus_sensor.location, subline: @bus_sensor.subline } }, as: :json
    assert_response 200
  end

  test "should destroy bus_sensor" do
    assert_difference('BusSensor.count', -1) do
      delete bus_sensor_url(@bus_sensor), as: :json
    end

    assert_response 204
  end
end
