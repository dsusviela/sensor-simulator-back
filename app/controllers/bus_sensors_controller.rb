class BusSensorsController < ApplicationController
  before_action :set_bus_sensor, only: [:show, :update, :destroy]

  # GET /bus_sensors
  def index
    @bus_sensors = BusSensor.all

    response = []
    @bus_sensors.each do |sensor|
      attrs = sensor.attributes
      attrs[:location] = sensor.location
      response << attrs
    end

    render json: response
  end

  # GET /bus_sensors/1
  def show
    location = @bus_sensor.location
    response = @bus_sensor.attributes
    response[:location] = location
    render json: response
  end

  # POST /bus_sensors
  def create
    @bus_sensor = BusSensor.new(bus_sensor_params)
    @bus_sensor.service_group = ServiceGroupHelper.get_or_initialize_service_group(false)

    if @bus_sensor.save
      render json: @bus_sensor, status: :created
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

  # DELETE /beach_sensors/
  def delete_all
    BusSensor.all.each do |sensor|
      sensor.destroy
    end
  end

  def preload_data
    Rake::Task['bus:preload_data'].invoke

    render head: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_sensor
      @bus_sensor = BusSensor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bus_sensor_params
      params.require(:bus_sensor).permit(:line, :subline, :direction, :alive, :location_index)
    end
end
