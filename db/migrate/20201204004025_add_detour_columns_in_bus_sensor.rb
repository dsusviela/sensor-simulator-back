class AddDetourColumnsInBusSensor < ActiveRecord::Migration[6.0]
  def change
    add_column :line, :string
    add_column :subline, :string
    add_column :direction, :string
    add_column :location_index, :integer
  end
end
