class CreateBusSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :bus_sensors do |t|
      t.string :line
      t.string :subline
      t.string :direction
      t.st_point :location
      t.string :device_id
      t.string :entity_name
      t.string :entity_type
      t.boolean :alive
      t.boolean :fixed

      t.timestamps
    end
  end
end
