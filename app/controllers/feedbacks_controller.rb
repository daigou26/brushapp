class FeedbacksController < ApplicationController
  before_action :user_signed_in?, only: [:create]

  def new
    @post = Post.find(params[:id])
    if user_signed_in?
      if current_user.posts.find_by(id: params[:id]) == nil
        @feedback = current_user.feedbacks.build
      else
        @feed_items = @post.feed.paginate(page: params[:page], :per_page => 3)
      end
    end
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    @feedback.post_id = params[:id]

    if @feedback.save
      redirect_to root_path
    else
      @post = Post.find(params[:id])
      render "new"
    end
  end

  private
    def feedback_params
      params.require(:feedback).permit(:content, :rating)
    end
end
