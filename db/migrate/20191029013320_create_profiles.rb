class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :suburb
      t.integer :post_code
      t.string :state

      t.timestamps
    end
  end
end
