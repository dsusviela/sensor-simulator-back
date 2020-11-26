class CreateSensorView < ActiveRecord::Migration[6.0]
  def self.up
    sql_statement =<<-HEREEND
    CREATE OR REPLACE VIEW sensors AS
      SELECT beach_sensors.id, beach_sensors.location,
             beach_sensors.device_id, beach_sensors.entity_name,
             beach_sensors.entity_type, beach_sensors.alive,
             beach_sensors.fixed
             FROM beach_sensors
      UNION ALL
      SELECT bus_sensors.id, bus_sensors.location,
             bus_sensors.device_id, bus_sensors.entity_name,
             bus_sensors.entity_type, bus_sensors.alive,
             bus_sensors.fixed
             FROM bus_sensors
    HEREEND

    execute(sql_statement)
  end

  def self.down
    execute('DROP VIEW sensors;')
  end
end
