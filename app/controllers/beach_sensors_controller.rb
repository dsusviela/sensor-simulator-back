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
    if @beach_sensor.update(beach_sensor_params)
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
      byebug
      params.require(:beach_sensor).permit(:location, :device_id, :entity_name, :entity_type, :random_ceil, :random_floor, :random_seed, :random_std_dev, :alive, :fixed)
    end
end
