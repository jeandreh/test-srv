class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
			t.references :product, index: true, foreign_key: true
			t.references :supply, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
