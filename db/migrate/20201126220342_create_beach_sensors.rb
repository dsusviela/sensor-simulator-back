class CreateBeachSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :beach_sensors do |t|
      t.st_point :location
      t.string :device_id
      t.string :entity_name
      t.string :entity_type
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
