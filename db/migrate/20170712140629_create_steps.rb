class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.text :step
      t.belongs_to :recipe, foreign_key: true

      t.timestamps
    end
  end
end
