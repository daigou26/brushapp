class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rating, :double
    add_column :posts, :rating_count, :integer
    add_column :posts, :review_count, :integer
    add_column :posts, :new_feedback_count, :integer
  end
end
