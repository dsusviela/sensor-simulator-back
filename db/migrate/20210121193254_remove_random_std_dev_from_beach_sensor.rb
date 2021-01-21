class RemoveRandomStdDevFromBeachSensor < ActiveRecord::Migration[6.0]
  def change
    remove_column :beach_sensors, :random_std_dev, :integer
  end
end
