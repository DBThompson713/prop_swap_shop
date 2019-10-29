class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :proper_name
      t.integer :price
      t.text :description
      t.string :plant_type
      t.boolean :sold

      t.timestamps
    end
  end
end
