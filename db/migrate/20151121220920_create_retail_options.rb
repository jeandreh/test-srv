class CreateRetailOptions < ActiveRecord::Migration
  def change
    create_table :retail_options do |t|
      t.string :name
      t.string :short_name
      t.text :description
      t.float :price
      t.belongs_to :product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
