class BeachSensorsController < ApplicationController
  before_action :set_beach_sensor, only: [:show, :update, :destroy]

  # GET /beach_sensors
  def index
    @beach_sensors = BeachSensor.all

    render json: @beach_sensors
  end

  # GET /beach_sensors/1
  def show
    render json: @beach_sensor
  end

  # POST /beach_sensors
  def create
    @beach_sensor = BeachSensor.new(beach_sensor_params)
    lon, lat = params[:beach_sensor][:location].split
    @beach_sensor.location = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)

    if @beach_sensor.save
      render json: @beach_sensor, status: :created, location: @beach_sensor
    else
      render json: @beach_sensor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beach_sensors/1
  def update
    sensor_params = beach_sensor_params.to_h
    location = params[:beach_sensor][:location]

    if location.present?
      lon, lat = location.split
      sensor_params[:location] = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)
    end

    if @beach_sensor.update(sensor_params)
      render json: @beach_sensor
    else
      render json: @beach_sensor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beach_sensors/1
  def destroy
    @beach_sensor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beach_sensor
      @beach_sensor = BeachSensor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def beach_sensor_params
      params.require(:beach_sensor).permit(:sensor_type, :location, :ngsi_device_id, :ngsi_entity_name, :ngsi_entity_type, :random_ceil, :random_floor, :random_seed, :random_std_dev, :alive, :fixed, :fixed_value)
    end
end
