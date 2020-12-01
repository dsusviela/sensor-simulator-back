class RemoveNgsiColumnsFromBeachSensors < ActiveRecord::Migration[6.0]
  def change
    remove_column :beach_sensors, :ngsi_device_id, :string
    remove_column :beach_sensors, :ngsi_entity_name, :string
    remove_column :beach_sensors, :ngsi_entity_type, :string
  end
end
