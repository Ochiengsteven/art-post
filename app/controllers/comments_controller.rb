class CommentsController < ApplicationController
  before_action :load_post, only: %i[new create destroy]
  before_action :load_comment, only: [:destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.create(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = 'Unable to create comment.'
      @comments = @post.comments
      render 'posts/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def load_comment
    @comment = @post.comments.find(params[:id])
  end
end
