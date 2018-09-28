class Post < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  mount_uploader :image, ImageUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validate :title_validate
  validate :content_validate
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
  validate :image_size

  def feed
    Feedback.where("post_id = ?", id)
  end

  private

    def title_validate
      if title.length == 0
        errors.add(:title, "サービス・アプリ名を入力してください")
      elsif title.length > 40
        errors.add(:title, "40文字以内で入力してください")
      end
    end

    def content_validate
      if content.length == 0
        errors.add(:content, "説明を入力してください")
      elsif content.length > 140
        errors.add(:content, "140文字以内で入力してください")
      end
    end

    def image_size
      if image.url == nil
        errors.add(:image, "画像を指定してください")
      elsif image.size > 1.megabytes
        errors.add(:image, "1MB以下の画像を指定してください")
      end
    end
end
