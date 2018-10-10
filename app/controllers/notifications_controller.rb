class NotificationsController < ApplicationController
  def index
    if user_signed_in? && current_user[:nickname] == params[:user_id]
      @feed_items = current_user.notification_feed.page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end
end
