class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = 'Unable to create comment.'
      @comments = @post.comments || []
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
