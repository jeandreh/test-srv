class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.float :quantity
      t.references :retail_option, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
