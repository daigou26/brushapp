class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:new, :edit, :update, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    if current_user[:nickname] == params[:nickname]
      @post = current_user.posts.build
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user[:nickname] == params[:nickname]
      @post = Post.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.new_feedback_count = 0
    @post.rating_count = 0
    @post.review_count = 0
    @post.rating = 0
    if @post.save
      redirect_to controller: 'feedbacks', action: 'new', nickname: current_user[:nickname], id: @post[:id]
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = post_params[:title]
    @post.content = post_params[:content]
    @post.url = post_params[:url]

    if post_params[:image] != nil
      @post.remove_image!
      @post.image = post_params[:image]
    end

    if @post.save
      redirect_to controller: 'feedbacks', action: 'new', nickname: current_user[:nickname], id: @post[:id]
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.remove_image = true
    @post.destroy
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :url, :image)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
