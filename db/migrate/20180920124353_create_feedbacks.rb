class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.integer :rating
      t.integer :priority_rate
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index(:feedbacks, [:post_id, :created_at], order: {created_at: :desc})
  end
end
