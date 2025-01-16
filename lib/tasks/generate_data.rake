namespace :data do
  desc "Generate product data file with 20,000 products, including duplicate names"

  task generate_products: :environment do
    require "yaml"
    puts "================ Start create sample products ===================="
    colors = %w[Red Black White Blue Silver Gray]
    fuel_types = %w[Petrol Diesel Electric Hybrid]
    transmission_types = %w[Automatic Manual]

    products = Array.new(2) do |i|
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
        is_new: [ true, false ].sample,
        transmission_type: transmission_types.sample
      }
    end

    # Lọc các giá trị index unique trùng lặp
    duplicates = []
    unique_keys = {}
    products.each do |product|
      key = product.values_at(:maker_id, :car_model_id, :prefecture_id, :body_type_id, :exported_at)
      if unique_keys.key?(key)
        duplicates << key unless duplicates.include?(key)
      else
        unique_keys[key] = product
      end
    end
    unique_products = unique_keys.values

    total_products = products.size
    total_duplicates = duplicates.size
    total_unique = unique_products.size

    puts stats = {
      total_products: total_products,
      total_unique: total_unique,
      total_duplicates: total_duplicates
    }
    puts "- There are : #{total_products} products"
    puts "- There are : #{total_duplicates} values duplicate"
    puts "- There are : #{total_unique} unique (valid)"

    # Lưu các giá trị unique vào file YAML
    unique_file_path = Rails.root.join("db/seeds/unique.yml")
    File.open(unique_file_path, "w") do |file|
      file.write(unique_products.to_yaml)
    end
    # Lưu các giá trị trùng lặp vào file YAML
    duplicates_file_path = Rails.root.join("db/seeds/duplicates.yml")
    File.open(duplicates_file_path, "w") do |file|
      file.write(duplicates.to_yaml)
    end
    # Lưu tất cả sản phẩm vào file YAML chính
    file_path = Rails.root.join("db/seeds/products.yml")
    File.open(file_path, "w") do |file|
      file.write(products.to_yaml)
    end

    puts "Product data file created at: #{file_path}"
    puts "================ Finish create sample products ===================="
  end
end
