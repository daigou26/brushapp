class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :post_id
      t.boolean :unread
      t.string :notification_type
      t.string :feedback_user_id

      t.timestamps
    end
  end
end
