class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    # we filter by category https://github.com/Haradd/Looks-Tasty/blob/zai-heroku/app/models/recipe.rb#L33
    add_index :categories, :name

    # we sort by reviews_count, reviews_average, created_at https://github.com/Haradd/Looks-Tasty/blob/zai-heroku/app/models/recipe.rb#L37
    add_index :recipes, :reviews_count
    add_index :recipes, :reviews_average
    add_index :recipes, :created_at

    # fullindex because we use LIKE for filtering https://github.com/Haradd/Looks-Tasty/blob/zai-heroku/app/models/recipe.rb#L33
    # sqlite doesn't support fulltext index
    unless Rails.env.development? || Rails.env.test?
      add_index :recipes, :name, type: :fulltext
    end
  end
end
