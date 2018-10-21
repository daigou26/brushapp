class AddStatusColumnsToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :status, :string, default: "private"
  end
end
