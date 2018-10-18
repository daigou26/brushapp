class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:new, :edit, :update, :create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    if user_signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.page(params[:page]).per(8)
    end
  end

  def new
    if user_signed_in? && current_user[:nickname] == params[:nickname]
      @post = current_user.posts.build
    else
      redirect_to root_path
    end
  end

  def edit
    if user_signed_in? && current_user[:nickname] == params[:nickname]
      @post = Post.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def show
    if user_signed_in? && current_user[:nickname] == params[:user_id]
      @post = Post.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in? && current_user[:nickname] == params[:nickname]
      @post = current_user.posts.build(post_params)
      @post.new_feedback_count = 0
      @post.rating_count = 0
      @post.review_count = 0
      @post.rating = 0
      if @post.save
        redirect_to action: 'show', user_id: current_user[:nickname], id: @post[:id]
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def update
    if user_signed_in? && current_user[:nickname] == params[:nickname]
      @post = Post.find(params[:id])
      @post.title = post_params[:title]
      @post.content = post_params[:content]
      @post.url = post_params[:url]

      if post_params[:image] != nil
        @post.remove_image!
        @post.image = post_params[:image]
      end

      if @post.save
        redirect_to action: 'show', user_id: current_user[:nickname], id: @post[:id]
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.remove_image = true
    if current_user.notifications.exists?(post_id: params[:id])
      current_user.notifications.find_by(post_id: params[:id]).destroy
    end
    @post.destroy
    redirect_to action: 'index', nickname: current_user[:nickname]
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :url, :image)
    end

    def correct_user
      if user_signed_in?
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
      else
        redirect_to root_path
      end
    end
end
