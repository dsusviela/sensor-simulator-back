class AddDetoursTable < ActiveRecord::Migration[6.0]
  def change
    create_table :detours do |t|
      # cosas relevantes para detour, por ejemplo un id
      # id
      # id linea
      # punto
      # indice

      t.string :line
      t.string :subline
      t.string :direction
      t.integer :location_index
      t.st_point :location, srid: 4326
    end
  end
end
