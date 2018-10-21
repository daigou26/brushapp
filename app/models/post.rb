class Post < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validate :title_validate
  validate :content_validate
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
  validate :image_size

  def feed
    Feedback.where("post_id = ?", id).order("created_at desc")
  end

  def high_rating_feed
    Feedback.where("post_id = ?", id).order("rating desc")
  end

  def low_rating_feed
    Feedback.where("post_id = ?", id).order("rating asc")
  end

  # request feedback
  def request_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "request").order("created_at desc")
  end

  def high_rating_request_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "request").order("rating desc")
  end

  def low_rating_request_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "request").order("rating asc")
  end

  # question feedback
  def question_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "question").order("created_at desc")
  end

  def high_rating_question_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "question").order("rating desc")
  end

  def low_rating_question_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "question").order("rating asc")
  end

  # thought feedback
  def thought_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "thought").order("created_at desc")
  end

  def high_rating_thought_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "thought").order("rating desc")
  end

  def low_rating_thought_feed
    Feedback.where("post_id = ? and feedback_type = ?", id, "thought").order("rating asc")
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
