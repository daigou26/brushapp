class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  validate :empty_validate
  validate :content_validate


  private
    def empty_validate
      if rating == nil && content.length == 0
        errors.add(:rating, "評価またはフィードバックを入力してください")
      end
    end

    def content_validate
      if content.length > 140
        errors.add(:content, "140文字以内で入力してください")
      end
    end
end
