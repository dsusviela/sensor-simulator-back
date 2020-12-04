class BusSensorsController < ApplicationController
  # GET /detours
  def index
    @bus_sensors = Detour.all.group([:line, :subline, :direction])

    render json: @bus_sensors
  end
end
