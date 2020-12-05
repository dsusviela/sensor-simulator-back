class CreateDetours < ActiveRecord::Migration[6.0]
  def change
    create_table :detours do |t|
      t.string :line
      t.string :subline
      t.string :direction
      t.integer :location_index
      t.st_point :location, srid: 4326

      t.timestamps
    end
  end
end
