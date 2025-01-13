# Import dữ liệu mới hoặc cập nhật cũ
products = [
  { name: "Product A", price: 55.0 },
  { name: "Product B", price: 315.0 },
  { name: "Product C", price: 66.0 },
  { name: "Product D", price: 88.0 }
]

# Import với on_duplicate_key_update để xử lý dữ liệu trùng lặp
Product.import(
  [:name, :price],
  products.map { |p| [p[:name], p[:price]] },
  on_duplicate_key_update: [:price]
)

# Đặt lại AUTO_INCREMENT sau khi import
max_id = Product.maximum(:id) || 0
new_auto_increment = max_id + 1

ActiveRecord::Base.connection.execute(
  "ALTER TABLE products AUTO_INCREMENT = #{new_auto_increment}"
)

puts "Products after import:"
Product.all.each do |p|
  puts "Name: #{p.name}, Price: #{p.price}, Created At: #{p.created_at}, Updated At: #{p.updated_at}"
end
