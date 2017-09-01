class AddUserToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :user, index: true
    add_foreign_key :reviews, :users
  end
end
