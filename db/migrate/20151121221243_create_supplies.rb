class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :name
      t.float :price
      t.string :unity
      t.float :stock

      t.timestamps null: false
    end
  end
end
