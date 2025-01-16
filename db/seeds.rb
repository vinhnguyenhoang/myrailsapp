# Assuming PRICE_RANGES constant is available
PRICE_RANGES = [
  50_000, 100_000, 150_000, 200_000, 250_000, 300_000, 350_000,
  400_000, 450_000, 500_000, 600_000, 700_000, 800_000,
  900_000, 1_000_000, 1_200_000, 1_400_000, 1_500_000,
  1_600_000, 1_800_000, 2_000_000, 2_500_000, 3_000_000,
  3_500_000, 4_000_000, 4_500_000, 5_000_000, 6_000_000,
  7_000_000, 8_000_000, 9_000_000, 10_000_000
]

# Seed import script
require 'yaml'
puts "start: seeding ===================="

file_path = Rails.root.join("db/seeds/products.yml")
products = YAML.safe_load(File.read(file_path), permitted_classes: [ Symbol, Date ], aliases: true)

puts "File .yml has #{products.count} products"

# Prepare products for import
products_to_import = products.map do |product_data|
  Product.new(
    maker_id: product_data[:maker_id],
    car_model_id: product_data[:car_model_id],
    prefecture_id: product_data[:prefecture_id],
    body_type_id: product_data[:body_type_id],
    exported_at: product_data[:exported_at],
    color: product_data[:color],
    fuel_type: product_data[:fuel_type],
    mileage: product_data[:mileage],
    engine_capacity: product_data[:engine_capacity],
    is_new: product_data[:is_new],
    transmission_type: product_data[:transmission_type]
  ).tap do |product|
    # Map each stock range dynamically
    PRICE_RANGES.each do |price|
      product["stock_under_#{price}"] = product_data[:"stock_under_#{price}"]
    end
  end
end

# Import the data using ActiveRecord Import with `on_duplicate_key_update`
begin
  ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=0;")
  Product.import(
    products_to_import,
    on_duplicate_key_update: PRICE_RANGES.map { |price| :"stock_under_#{price}" },
    batch_size: 1000
  )
  ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=1;")
rescue StandardError => e
  puts "Error during import: #{e.message}"
end

puts "Imported #{Product.all.count} products using ActiveRecord Import."
