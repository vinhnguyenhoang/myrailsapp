# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_13_081716) do
  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "maker_id", null: false
    t.integer "car_model_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "body_type_id", null: false
    t.date "exported_at", null: false
    t.integer "stock_under_50000", default: 0, null: false
    t.integer "stock_under_100000", default: 0, null: false
    t.integer "stock_under_150000", default: 0, null: false
    t.integer "stock_under_200000", default: 0, null: false
    t.integer "stock_under_250000", default: 0, null: false
    t.integer "stock_under_300000", default: 0, null: false
    t.integer "stock_under_350000", default: 0, null: false
    t.integer "stock_under_400000", default: 0, null: false
    t.integer "stock_under_450000", default: 0, null: false
    t.integer "stock_under_500000", default: 0, null: false
    t.integer "stock_under_600000", default: 0, null: false
    t.integer "stock_under_700000", default: 0, null: false
    t.integer "stock_under_800000", default: 0, null: false
    t.integer "stock_under_900000", default: 0, null: false
    t.integer "stock_under_1000000", default: 0, null: false
    t.integer "stock_under_1200000", default: 0, null: false
    t.integer "stock_under_1400000", default: 0, null: false
    t.integer "stock_under_1500000", default: 0, null: false
    t.integer "stock_under_1600000", default: 0, null: false
    t.integer "stock_under_1800000", default: 0, null: false
    t.integer "stock_under_2000000", default: 0, null: false
    t.integer "stock_under_2500000", default: 0, null: false
    t.integer "stock_under_3000000", default: 0, null: false
    t.integer "stock_under_3500000", default: 0, null: false
    t.integer "stock_under_4000000", default: 0, null: false
    t.integer "stock_under_4500000", default: 0, null: false
    t.integer "stock_under_5000000", default: 0, null: false
    t.integer "stock_under_6000000", default: 0, null: false
    t.integer "stock_under_7000000", default: 0, null: false
    t.integer "stock_under_8000000", default: 0, null: false
    t.integer "stock_under_9000000", default: 0, null: false
    t.integer "stock_under_10000000", default: 0, null: false
    t.string "color", null: false
    t.string "fuel_type", null: false
    t.integer "mileage", default: 0, null: false
    t.decimal "engine_capacity", precision: 5, scale: 2, null: false
    t.boolean "is_new", default: true, null: false
    t.string "transmission_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["maker_id", "car_model_id", "prefecture_id", "body_type_id", "exported_at"], name: "index_products", unique: true
  end
end
