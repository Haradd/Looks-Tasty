require "factory_girl_rails"

puts "Creating categories..."
categories = ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]
categories.each do |category|
  Category.create!(name: category)
end
puts "Created categories: #{categories}"

puts "Creating users..."
user_count = 50
user_count.times do
  User.create!(
    username: FFaker::Internet.user_name,
    email: FFaker::Internet.email,
    password: FFaker::Internet.password
  )
  print "."
end
puts "Created #{user_count} users"

puts "Creating recipes..."
recipe_count = 15
recipe_count.times do
  user_id = rand(1..user_count)
  category = categories.sample

  recipe = Recipe.new(
    user: User.find(user_id),
    category: Category.find_by(name: category),
    name: FFaker::Lorem.words(rand(3..6)).join(" "),
    description: FFaker::Lorem.sentence,
    image: FFaker::Avatar.image,
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
end
puts "Created #{recipe_count} recipes"

puts "Creating reviews..."
(1..user_count).to_a.each do |user_id|
  rand(5..recipe_count).times do
    Review.create!(
      rating: rand(2..5),
      comment: FFaker::Lorem.sentence,
      user: User.find(user_id),
      recipe: Recipe.find(rand(1..recipe_count))
    )
  end
end
puts "Created reviews"
