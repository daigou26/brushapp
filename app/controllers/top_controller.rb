class TopController < ApplicationController
  def index
    if user_signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5)
    end
  end
end
