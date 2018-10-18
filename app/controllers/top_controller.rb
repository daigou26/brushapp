class TopController < ApplicationController
  def index
    # tab切り替え
    feed_type = request.fullpath.split("/").last

    if feed_type == nil
      @feed_items = Post.where("rating >= ?", 4).order("rating desc").limit(6)
      @new_feed_items = Post.order("created_at desc").limit(6)
    elsif feed_type.include?("type=rating")
      @feed_items = Post.where("rating >= ?", 4).order("rating desc").limit(60).page(params[:page]).per(12)
    elsif feed_type.include?("type=new")
      @feed_items = Post.order("created_at desc").limit(60).page(params[:page]).per(12)
    end
  end
end
