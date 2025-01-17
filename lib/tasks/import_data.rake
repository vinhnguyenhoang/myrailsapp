PRICE_RANGES = [
  50_000, 100_000, 150_000, 200_000, 250_000, 300_000, 350_000,
  400_000, 450_000, 500_000, 600_000, 700_000, 800_000,
  900_000, 1_000_000, 1_200_000, 1_400_000, 1_500_000,
  1_600_000, 1_800_000, 2_000_000, 2_500_000, 3_000_000,
  3_500_000, 4_000_000, 4_500_000, 5_000_000, 6_000_000,
  7_000_000, 8_000_000, 9_000_000, 10_000_000
]

namespace :data do
  desc "Generate and import 1,000,000 products into the database with duplicates tracking"
  task import_products: :environment do
    puts "================ Start importing products ===================="

    colors = %w[Red Black White Blue Silver Gray]
    fuel_types = %w[Petrol Diesel Electric Hybrid]
    transmission_types = %w[Automatic Manual]

    total_products = 800_000
    batch_size = 10_000
    num_batches = (total_products.to_f / batch_size).ceil

    all_products = []
    unique_keys = {}
    duplicate_count = 0

    num_batches.times do |batch_index|
      puts "Processing batch #{batch_index + 1} of #{num_batches}..."

      products = Array.new(batch_size) do
        {
          maker_id: rand(1..30),
          car_model_id: rand(1..30),
          prefecture_id: rand(1..30),
          body_type_id: rand(1..30),
          exported_at: Faker::Date.between(from: 3.days.ago, to: Date.today),
          color: colors.sample,
          fuel_type: fuel_types.sample,
          mileage: rand(0..200_000),
          engine_capacity: rand(1.0..4.0).round(2),
          is_new: [ true, false ].sample,
          transmission_type: transmission_types.sample
        }.merge(
          PRICE_RANGES.map { |price| [ :"stock_under_#{price}", rand(0..10) ] }.to_h
        )
      end

      # Check for duplicates
      products.each do |product|
        unique_key = product.values_at(:maker_id, :car_model_id, :prefecture_id, :body_type_id, :exported_at)
        if unique_keys.key?(unique_key)
          duplicate_count += 1
        else
          unique_keys[unique_key] = product
          all_products << product
        end
      end
    end
    puts "================ Import Summary ===================="
    puts "Total Products: #{total_products}"
    puts "Unique Products: #{all_products.size}"
    puts "Duplicate Products: #{duplicate_count}"
    # Import unique products
    Product.import(
      all_products.map { |product| Product.new(product) },
      on_duplicate_key_update: PRICE_RANGES.map { |price| :"stock_under_#{price}" },
      batch_size: 10_000
    )
    puts "Total Products import: #{Product.all.size}"
    puts "================ Finish importing products ===================="
  end
end
