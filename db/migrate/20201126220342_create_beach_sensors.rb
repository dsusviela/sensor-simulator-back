class CreateBeachSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :beach_sensors do |t|
      t.integer :type
      t.st_point :location, srid: 4326
      t.string :ngsi_device_id
      t.string :ngsi_entity_name
      t.string :ngsi_entity_type
      t.integer :random_ceil
      t.integer :random_floor
      t.integer :random_seed
      t.integer :random_std_dev
      t.boolean :alive
      t.boolean :fixed

      t.timestamps
    end
  end
end
