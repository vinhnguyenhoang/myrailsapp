class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.integer :maker_id, null: false
      t.integer :car_model_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :body_type_id, null: false
      t.date :exported_at, null: false

      # Stock levels based on price ranges
      t.integer :stock_under_50000, default: 0, null: false
      t.integer :stock_under_100000, default: 0, null: false
      t.integer :stock_under_150000, default: 0, null: false
      t.integer :stock_under_200000, default: 0, null: false
      t.integer :stock_under_250000, default: 0, null: false
      t.integer :stock_under_300000, default: 0, null: false
      t.integer :stock_under_350000, default: 0, null: false
      t.integer :stock_under_400000, default: 0, null: false
      t.integer :stock_under_450000, default: 0, null: false
      t.integer :stock_under_500000, default: 0, null: false
      t.integer :stock_under_600000, default: 0, null: false
      t.integer :stock_under_700000, default: 0, null: false
      t.integer :stock_under_800000, default: 0, null: false
      t.integer :stock_under_900000, default: 0, null: false
      t.integer :stock_under_1000000, default: 0, null: false
      t.integer :stock_under_1200000, default: 0, null: false
      t.integer :stock_under_1400000, default: 0, null: false
      t.integer :stock_under_1500000, default: 0, null: false
      t.integer :stock_under_1600000, default: 0, null: false
      t.integer :stock_under_1800000, default: 0, null: false
      t.integer :stock_under_2000000, default: 0, null: false
      t.integer :stock_under_2500000, default: 0, null: false
      t.integer :stock_under_3000000, default: 0, null: false
      t.integer :stock_under_3500000, default: 0, null: false
      t.integer :stock_under_4000000, default: 0, null: false
      t.integer :stock_under_4500000, default: 0, null: false
      t.integer :stock_under_5000000, default: 0, null: false
      t.integer :stock_under_6000000, default: 0, null: false
      t.integer :stock_under_7000000, default: 0, null: false
      t.integer :stock_under_8000000, default: 0, null: false
      t.integer :stock_under_9000000, default: 0, null: false
      t.integer :stock_under_10000000, default: 0, null: false

      # Additional fields for diversity
      t.string :color, null: false
      t.string :fuel_type, null: false
      t.integer :mileage, default: 0, null: false
      t.decimal :engine_capacity, precision: 5, scale: 2, null: false
      t.boolean :is_new, default: true, null: false
      t.string :transmission_type, null: false

      t.timestamps
    end
    add_index :products, [:maker_id, :car_model_id, :prefecture_id, :body_type_id, :exported_at], unique: true, name: "index_products"
  end
end
