class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # post feed
  def feed
    Post.where("user_id = ?", id).order("created_at desc")
  end

  def notification_feed
    Notification.where("user_id = ?", id).order("created_at desc")
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        name: auth.info.name,
        nickname: auth.info.nickname,
        )
    else
      isChanged = false
      if user[:image] != auth.info.image
        user[:image] = auth.info.image
        isChanged = true
      end

      if user[:name] != auth.info.name
        user[:name] = auth.info.name
        isChanged = true
      end

      if user[:nickname] != auth.info.nickname
        user[:nickname] = auth.info.nickname
        isChanged = true
      end

      if isChanged
        user.save!
      end
    end

    user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
