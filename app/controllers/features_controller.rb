require 'rgeo/geo_json'

class FeaturesController < ApplicationController

  def create
    geom = geojson_decoder.decode(sensor_agua_create_params[:geom].to_h)
    new_params = sensor_agua_create_params.to_h
    new_params[:geom] = geom

    sensor = SensorAgua.create(new_params)

    render json: sensor.reload
  end

  def update
    sensor = SensorAgua.find(params[:id])

    new_params = sensor_agua_params.to_h
    geom_param = sensor_agua_params[:geom]
    if geom_param.present?
      geom = geojson_decoder.decode(geom_param.to_h)
      new_params[:geom] = geom
    end

    sensor.update(new_params)

    render json: sensor
  end

  def destroy
    sensor = SensorAgua.find(params[:id])
    sensor.delete

    head :no_content
  end

  private

  def sensor_agua_params
    params.require(:feature).permit([:id, :id_playa, :valor, geom: [:type, coordinates: []]])
  end

  def sensor_agua_create_params
    sensor_agua_params.tap do |sensor_params|
      sensor_params.require([:id, :id_playa, :geom])
    end
  end


  def geojson_decoder
    @geojson_decoder ||= RGeo::GeoJSON::Coder.new(geo_factory: RGeo::Geographic.spherical_factory(srid: 4326))
  end
end
