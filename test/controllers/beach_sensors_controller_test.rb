require 'test_helper'

class BeachSensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beach_sensor = beach_sensors(:one)
  end

  test "should get index" do
    get beach_sensors_url, as: :json
    assert_response :success
  end

  test "should create beach_sensor" do
    assert_difference('BeachSensor.count') do
      post beach_sensors_url, params: { beach_sensor: { device_id: @beach_sensor.device_id, entity_name: @beach_sensor.entity_name, entity_type: @beach_sensor.entity_type, location: @beach_sensor.location, random_ceil: @beach_sensor.random_ceil, random_floor: @beach_sensor.random_floor, random_seed: @beach_sensor.random_seed, random_std_dev=integer: @beach_sensor.random_std_dev=integer } }, as: :json
    end

    assert_response 201
  end

  test "should show beach_sensor" do
    get beach_sensor_url(@beach_sensor), as: :json
    assert_response :success
  end

  test "should update beach_sensor" do
    patch beach_sensor_url(@beach_sensor), params: { beach_sensor: { device_id: @beach_sensor.device_id, entity_name: @beach_sensor.entity_name, entity_type: @beach_sensor.entity_type, location: @beach_sensor.location, random_ceil: @beach_sensor.random_ceil, random_floor: @beach_sensor.random_floor, random_seed: @beach_sensor.random_seed, random_std_dev=integer: @beach_sensor.random_std_dev=integer } }, as: :json
    assert_response 200
  end

  test "should destroy beach_sensor" do
    assert_difference('BeachSensor.count', -1) do
      delete beach_sensor_url(@beach_sensor), as: :json
    end

    assert_response 204
  end
end
