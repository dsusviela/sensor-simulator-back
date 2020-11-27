class CreateServiceGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :service_groups do |t|
      t.string :apikey
      t.boolean :is_beach

      t.timestamps
    end
  end
end
