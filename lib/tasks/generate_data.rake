namespace :data do
  desc "Generate product data file with 1,000,000 products in batches"
  task generate_products: :environment do
    require "yaml"
    puts "================ Start creating sample products ===================="

    colors = %w[Red Black White Blue Silver Gray]
    fuel_types = %w[Petrol Diesel Electric Hybrid]
    transmission_types = %w[Automatic Manual]

    batch_size = 10_000
    total_products = 100_000
    num_batches = (total_products.to_f / batch_size).ceil

    all_products = []   # Chứa toàn bộ sản phẩm (bao gồm cả trùng lặp)
    unique_keys = {}    # Chứa các sản phẩm duy nhất
    duplicates = []     # Chứa key của các sản phẩm trùng lặp

    num_batches.times do |batch_index|
      puts "Processing batch #{batch_index + 1} of #{num_batches}..."

      # Tạo batch sản phẩm
      products = Array.new(batch_size) do
        {
          maker_id: rand(1..10),
          car_model_id: rand(1..10),
          prefecture_id: rand(1..10),
          body_type_id: rand(1..10),
          exported_at: Faker::Date.between(from: 3.days.ago, to: Date.today),
          stock_under_50000: rand(0..10),
          stock_under_100000: rand(0..10),
          stock_under_150000: rand(0..10),
          stock_under_200000: rand(0..10),
          stock_under_250000: rand(0..10),
          stock_under_300000: rand(0..10),
          stock_under_350000: rand(0..10),
          stock_under_400000: rand(0..10),
          stock_under_450000: rand(0..10),
          stock_under_500000: rand(0..10),
          stock_under_600000: rand(0..10),
          stock_under_700000: rand(0..10),
          stock_under_800000: rand(0..10),
          stock_under_900000: rand(0..10),
          stock_under_1000000: rand(0..10),
          stock_under_1200000: rand(0..10),
          stock_under_1400000: rand(0..10),
          stock_under_1500000: rand(0..10),
          stock_under_1600000: rand(0..10),
          stock_under_1800000: rand(0..10),
          stock_under_2000000: rand(0..10),
          stock_under_2500000: rand(0..10),
          stock_under_3000000: rand(0..10),
          stock_under_3500000: rand(0..10),
          stock_under_4000000: rand(0..10),
          stock_under_4500000: rand(0..10),
          stock_under_5000000: rand(0..10),
          stock_under_6000000: rand(0..10),
          stock_under_7000000: rand(0..10),
          stock_under_8000000: rand(0..10),
          stock_under_9000000: rand(0..10),
          stock_under_10000000: rand(0..10),
          color: colors.sample,
          fuel_type: fuel_types.sample,
          mileage: rand(0..200_000),
          engine_capacity: rand(1.0..4.0).round(2),
          is_new: [true, false].sample,
          transmission_type: transmission_types.sample
        }
      end

      # Lưu batch vào danh sách tất cả sản phẩm
      all_products.concat(products)

      # Phân loại sản phẩm thành unique và duplicates
      products.each do |product|
        key = product.values_at(:maker_id, :car_model_id, :prefecture_id, :body_type_id, :exported_at)
        if unique_keys.key?(key)
          duplicates << product unless duplicates.include?(product)
        else
          unique_keys[key] = product
        end
      end
    end

    unique_products = unique_keys.values
    total_duplicates = duplicates.size
    total_unique = unique_products.size
    total_products = all_products.size

    puts stats = {
      total_products: total_products,
      total_unique: total_unique,
      total_duplicates: total_duplicates
    }

    # Lưu dữ liệu vào file YAML
    all_file_path = Rails.root.join("db/seeds/products.yml")
    unique_file_path = Rails.root.join("db/seeds/unique.yml")
    duplicates_file_path = Rails.root.join("db/seeds/duplicates.yml")

    File.open(all_file_path, "w") { |file| file.write(all_products.to_yaml) }
    File.open(unique_file_path, "w") { |file| file.write(unique_products.to_yaml) }
    File.open(duplicates_file_path, "w") { |file| file.write(duplicates.to_yaml) }

    puts "All products saved to: #{all_file_path}"
    puts "Unique products saved to: #{unique_file_path}"
    puts "Duplicates saved to: #{duplicates_file_path}"
    puts "================ Finish creating sample products ===================="
  end
end
