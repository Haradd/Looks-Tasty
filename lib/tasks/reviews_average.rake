desc "Compute reviews average for each Recipe"

task reviews_average: :environment do
  Recipe.find_each do |r|
    average = r.reviews.sum(:rating).to_f / r.reviews_count.to_f
    r.update_attribute(:reviews_average, average.round(2))
    r.save
  end
end
