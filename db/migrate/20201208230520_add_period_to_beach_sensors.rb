class AddPeriodToBeachSensors < ActiveRecord::Migration[6.0]
  def change
    add_column :beach_sensors, :period, :integer
  end
end
