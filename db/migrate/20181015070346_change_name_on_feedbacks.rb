class ChangeNameOnFeedbacks < ActiveRecord::Migration[5.2]
  def change
    rename_column :feedbacks, :priority_rate, :priority_value
  end
end
