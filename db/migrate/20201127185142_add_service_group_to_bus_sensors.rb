class AddServiceGroupToBusSensors < ActiveRecord::Migration[6.0]
  def change
    add_reference :bus_sensors, :service_group, null: false, foreign_key: true
  end
end
