class FeedbacksController < ApplicationController
  before_action :user_signed_in?, only: [:create]

  def new
    @post = Post.find(params[:id])
    if user_signed_in?
      if current_user.posts.find_by(id: params[:id]) == nil
        @feedback = current_user.feedbacks.build
      else
        @post.new_feedback_count = 0
        @post.save
        @feed_items = @post.feed.page(params[:page]).per(10)
      end
    end
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    @feedback.post_id = params[:id]
    @post = Post.find(params[:id])
    if @feedback.save
      @post.new_feedback_count = @post.new_feedback_count + 1
      if @feedback.rating != nil
        @post.rating = (@post.rating * @post.rating_count + @feedback.rating) / (@post.rating_count + 1)
        @post.rating_count = @post.rating_count + 1
      end

      if @feedback.content != nil
        @post.review_count = @post.review_count + 1
      end

      @post.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private
    def feedback_params
      params.require(:feedback).permit(:content, :rating)
    end
end
