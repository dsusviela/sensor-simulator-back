class AddBeachIdToBeachSensors < ActiveRecord::Migration[6.0]
  def change
    add_column :beach_sensors, :beach_id, :integer
  end
end
