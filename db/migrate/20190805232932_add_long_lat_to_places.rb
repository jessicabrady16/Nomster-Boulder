class AddLongLatToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :longitude, :decimal
    add_column :places, :latitude, :decimal

  end
end

