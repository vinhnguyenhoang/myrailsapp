# Import new data
def update_auto_increment_for(model)
  max_id = model.maximum(:id) || 0
  new_auto_increment = max_id + 1
  ActiveRecord::Base.connection.execute(
    "ALTER TABLE #{model.table_name} AUTO_INCREMENT = #{new_auto_increment}"
  )
end
products = [
  { name: "Product A", price: 1 },
  { name: "Product B", price: 2 },
  { name: "Product C", price: 3 },
  { name: "Product D", price: 4 }
]
Product.import(
  [:name, :price],
  products,
  on_duplicate_key_update: [:price]
)

# update value AUTO_INCREMENT
# update_auto_increment_for(Product)

puts "Products new data import:"
Product.all.each do |p|
  puts "ID: #{p.id}, Name: #{p.name}, Price: #{p.price}, Created At: #{p.created_at}, Updated At: #{p.updated_at}"
end

new_products = [
  { name: "Product E", price: 315.0 },
  { name: "Product C", price: 6.0 },
  { name: "Product A", price: 89.0 },
  { name: "Product G", price: 83.0 }
]

Product.import(
  [:name, :price],
  new_products,
  on_duplicate_key_update: [:price]
)

# update value AUTO_INCREMENT
# update_auto_increment_for(Product)

puts "Products data import 2:"
Product.all.each do |p|
  puts "ID: #{p.id}, Name: #{p.name}, Price: #{p.price}, Created At: #{p.created_at}, Updated At: #{p.updated_at}"
end

# Import new data after insert duplicate
new_products = [
  { name: "Product H", price: 1 },
  { name: "Product K", price: 2 },
  { name: "Product C", price: 3 },
  { name: "Product D", price: 4 },
  { name: "Product E", price: 5 },
  { name: "Product L", price: 6 },
  { name: "Product A", price: 7 },
  { name: "Product G", price: 8 }
]

Product.import(
  [:name, :price],
  new_products,
  on_duplicate_key_update: [:price]
)

# update value AUTO_INCREMENT
# update_auto_increment_for(Product)

puts "Products data import 3:"
Product.all.each do |p|
  puts "ID: #{p.id}, Name: #{p.name}, Price: #{p.price}, Created At: #{p.created_at}, Updated At: #{p.updated_at}"
end

# Import new data after insert duplicate
new_products = [
  { name: "Product M", price: 1 },
  { name: "Product N", price: 2 },
  { name: "Product O", price: 3 },
]

Product.import(
  [:name, :price],
  new_products,
  on_duplicate_key_update: [:price]
)

puts "Products after import:"
Product.all.each do |p|
  puts "ID: #{p.id}, Name: #{p.name}, Price: #{p.price}, Created At: #{p.created_at}, Updated At: #{p.updated_at}"
end
