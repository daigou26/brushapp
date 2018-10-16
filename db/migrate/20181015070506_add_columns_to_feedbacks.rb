class AddColumnsToFeedbacks < ActiveRecord::Migration[5.2]
  def change
   add_column :feedbacks, :feedback_type, :string
   add_index(:feedbacks, [:post_id, :feedback_type, :created_at], order: {created_at: :desc}, :name => 'feedbacks_created_at_index')
   add_index(:feedbacks, [:post_id, :feedback_type, :priority_value], order: {priority_value: :desc}, :name => 'feedbacks_priority_index')
 end
end
