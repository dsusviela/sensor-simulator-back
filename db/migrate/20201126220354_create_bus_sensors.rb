class CreateBusSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :bus_sensors do |t|
      t.string :line
      t.string :subline
      t.string :direction
      # t.st_point :location, srid: 4326
      t.string :ngsi_device_id
      t.string :ngsi_entity_name
      t.string :ngsi_entity_type
      t.boolean :alive

      t.timestamps
    end
  end
end
