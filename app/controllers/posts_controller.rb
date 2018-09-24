class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to controller: 'feedbacks', action: 'new', nickname: current_user[:nickname], id: @post[:id]
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_path
  end

  def new
    if current_user[:nickname] == params[:nickname]
      @post = current_user.posts.build
    else
      redirect_to root_path
    end
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
