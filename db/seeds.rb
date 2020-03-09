require "factory_girl_rails"

puts "Creating categories..."
categories = ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]
categories.each do |category|
  Category.where(name: category).first_or_create!
end
puts "Created categories: #{categories}"

puts "Creating users..."
user_count = 250
user_count.times do |tim|
  User.where(
    username: "test#{tim}",
    email: "test#{tim}@gmail.com",
  ).first_or_create!(password: "testtest#{tim}").update_columns(confirmed_at: 1.day.ago)
  print "."
end
puts "Created #{user_count} users"

puts "Creating recipes..."
recipe_count = 1000
while Recipe.count < 1000 do
  begin
    user_id = rand(1..user_count)
    category = categories.sample
    
    recipe = Recipe.new(
      user: User.find(user_id),
      category: Category.find_by(name: category),
      name: FFaker::Lorem.words(rand(3..6)).join(" "),
      description: FFaker::Lorem.sentence,
      image: open(FFaker::Avatar.image),
      tip: FFaker::Lorem.sentence,
      portions: rand(1..6),
      time: FFaker::Time.datetime
    )
  
    steps = Array.new(rand(1..10)) { { step: FFaker::Lorem.sentence } }
    ingredients = Array.new(rand(1..10)) { { name: FFaker::Lorem.words(rand(1..4)).join(" ") } }
  
    recipe.steps.build(steps)
    recipe.ingredients.build(ingredients)
    recipe.save
    print "."
  rescue
    print "error"
  end
end
puts "Created #{recipe_count} recipes"

puts "Creating reviews..."
# each user adds random number of reviews
recipes = Recipe.all
User.all.each do |user|
  break if Review.count >= user_count * recipe_count

  rand(5..recipe_count).times do
    Review.create!(
      rating: rand(2..5),
      comment: FFaker::Lorem.sentence,
      user: User.find(user_id),
      recipe: recipe.sample
    )
    print '.'
  rescue
    print "error"
  end
end
puts "Created reviews"

puts "Creating admin user..."
if Rails.env.development?
  AdminUser.where!(email: 'admin@example.com').first_or_create!(password: 'password', password_confirmation: 'password')
  print '.'
end
puts "Created admin user"
