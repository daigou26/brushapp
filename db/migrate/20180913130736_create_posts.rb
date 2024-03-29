class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :url
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index(:posts, [:user_id, :created_at], order: {created_at: :desc})
  end
end
