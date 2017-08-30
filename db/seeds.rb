puts 'Creating categories'

categories = ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]
categories.each do |category|
     Category.create!(name: category)
   end
puts "Created categories: #{categories.to_s}"
