class BusSensorsController < ApplicationController
  before_action :set_bus_sensor, only: [:show, :update, :destroy]

  # GET /bus_sensors
  def index
    @bus_sensors = BusSensor.all

    render json: @bus_sensors
  end

  # GET /bus_sensors/1
  def show
    render json: @bus_sensor
  end

  # POST /bus_sensors
  def create
    @bus_sensor = BusSensor.new(bus_sensor_params)
    lon, lat = params[:beach_sensor][:location].split
    @bus_sensor.location = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)

    if @bus_sensor.save
      render json: @bus_sensor, status: :created, location: @bus_sensor
    else
      render json: @bus_sensor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bus_sensors/1
  def update
    if @bus_sensor.update(bus_sensor_params)
      render json: @bus_sensor
    else
      render json: @bus_sensor.errors, status: :unprocessable_entity
    end
  end

  def update
    sensor_params = bus_sensor_params.to_h
    location = params[:bus_sensor][:location]

    if location.present?
      lon, lat = location.split
      sensor_params[:location] = RGeo::Geographic.spherical_factory(srid: ENV['SRID']).point(lon, lat)
    end

    if @bus_sensor.update(sensor_params)
      render json: @bus_sensor
    else
      render json: @bus_sensor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bus_sensors/1
  def destroy
    @bus_sensor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_sensor
      @bus_sensor = BusSensor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bus_sensor_params
      params.require(:bus_sensor).permit(:line, :subline, :direction, :location, :ngsi_device_id, :ngsi_entity_name, :ngsi_entity_type, :alive)
    end
end
