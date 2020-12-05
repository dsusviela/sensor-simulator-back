class DetoursController < ApplicationController
  # GET /detours
  def index
    @detours = Detour.all.select(:line, :subline, :direction).distinct

    render json: @detours
  end
end
