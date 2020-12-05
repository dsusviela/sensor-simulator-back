class AddIndexToBusSensors < ActiveRecord::Migration[6.0]
  def change
    add_column :bus_sensors, :location_index, :integer
  end
end
