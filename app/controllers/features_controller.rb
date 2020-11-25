require 'rgeo/geo_json'

class FeaturesController < ApplicationController

  def create
    current_params = feature_params(required: true)
    geom = geojson_decoder.decode(current_params[:geom].to_h)
    new_params = current_params.to_h
    new_params[:geom] = geom

    feature = Feature.create_by_type(params[:feature_type], new_params)

    render json: feature.reload
  end

  def update
    # Esto no anda todavia
    # Habria que definir un método find_by_type en Feature
    feature = Feature.find(params[:id])

    current_params = feature_params(required: false)

    new_params = current_params.to_h
    geom_param = current_params[:geom]
    if geom_param.present?
      geom = geojson_decoder.decode(geom_param.to_h)
      new_params[:geom] = geom
    end

    feature.update_by_type(params[:feature_type], new_params)

    render json: feature
  end

  def destroy
    # Esto tampoco todavia
    feature = Feature.find(params[:id])
    feature.delete

    head :no_content
  end

  private

  def feature_params(required: false)
    params.require(:feature_type)
    feature_params_by_type(required)
  end

  def feature_params_by_type(required)
    case params[:feature_type]
    when 'playa'
      if required
        playa_required_params
      else
        playa_params
      end
    else
      if required
        sensor_required_params
      else
        sensor_params
      end
    end
  end

  def playa_params
    params.require(:feature).permit([:nombre, :puntaje, geom: [:type, coordinates: []]])
  end

  def playa_required_params
    playa_params.tap do |p_params|
      p_params.require([:nombre, :geom])
    end
  end

  def sensor_params
    params.require(:feature).permit([:id_playa, :valor, geom: [:type, coordinates: []]])
  end

  def sensor_required_params
    sensor_params.tap do |s_params|
      s_params.require([:id_playa, :geom])
    end
  end

  def geojson_decoder
    @geojson_decoder ||= RGeo::GeoJSON::Coder.new(geo_factory: RGeo::Geographic.spherical_factory(srid: 4326))
  end
end
