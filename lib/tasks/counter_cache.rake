desc "Counter cache for recipe and user has many reviews"

task review_counter: :environment do
  Recipe.reset_column_information
  Recipe.find_each do |r|
    Recipe.reset_counters r.id, :reviews
  end

  User.reset_column_information
  User.find_each do |u|
    User.reset_counters u.id, :reviews
  end
end
