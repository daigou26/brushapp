class TopController < ApplicationController
  def index
    @feed_items = Post.where("rating >= ?", 4).order("rating desc").limit(6)
    @new_feed_items = Post.order("created_at desc").limit(6)
  end
end
