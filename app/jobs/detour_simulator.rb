class DetourSimulator
  def initialize
    @current_coordinate_index = 0
  end

  def next_location
    Detour.find(id).geom[next_location_index]
  end

  private

  def next_location_index
    @current_coordinate_index += 1
  end
end
