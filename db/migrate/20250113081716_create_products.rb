class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
