class CreateSimulatorProcesses < ActiveRecord::Migration[6.0]
  def change
    create_table :simulator_processes do |t|
      t.string :job_id
      t.boolean :is_beach

      t.timestamps
    end
  end
end
