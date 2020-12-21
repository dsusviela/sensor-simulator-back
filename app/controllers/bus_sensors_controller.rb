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
    BusSensor.delete_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_sensor
      @bus_sensor = BusSensor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bus_sensor_params
      params.require(:bus_sensor).permit(:line, :subline, :direction, :alive)
    end
end
