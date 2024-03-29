class TopController < ApplicationController
  def index
    # tab切り替え
    feed_type = request.fullpath.split("/").last
    now = Time.current

    if feed_type == nil
      @new_feed_items = Post.limit(6).order("created_at desc")
      @feed_items = Post.where("rating >= ?", 4).limit(6).order("rating desc")
    elsif feed_type.include?("type=rating")
      @feed_items = Post.where("rating >= ?", 4).order("rating desc").page(params[:page]).per(12)
    elsif feed_type.include?("type=new")
      @feed_items = Post.order("created_at desc").page(params[:page]).per(12)
    end
  end
end
