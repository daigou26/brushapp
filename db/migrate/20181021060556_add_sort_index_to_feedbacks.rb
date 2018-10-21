class AddSortIndexToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_index(:feedbacks, [:post_id, :rating], order: {rating: :desc})
    add_index(:feedbacks, [:post_id, :feedback_type, :rating], order: {rating: :desc}, :name => 'feedbacks_rating_index')
  end
end
