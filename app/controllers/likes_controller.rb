# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :load_post, only: [:create]

  def create
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to post_path(@post), notice: 'Post liked successfully.'
    else
      flash.now[:alert] = 'Unable to like the post.'
      render 'posts/show'
    end
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end
end
