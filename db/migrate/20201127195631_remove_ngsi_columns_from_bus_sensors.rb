class RemoveNgsiColumnsFromBusSensors < ActiveRecord::Migration[6.0]
  def change
    remove_column :bus_sensors, :ngsi_device_id, :string
    remove_column :bus_sensors, :ngsi_entity_name, :string
    remove_column :bus_sensors, :ngsi_entity_type, :string
  end
end
