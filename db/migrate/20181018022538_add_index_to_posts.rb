class AddIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index(:posts, :created_at, order: {created_at: :desc})
    add_index(:posts, :rating, order: {rating: :desc})
  end
end
