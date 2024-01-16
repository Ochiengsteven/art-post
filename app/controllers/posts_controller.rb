class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @recent_comments = {}

    @posts.each do |post|
      @recent_comments[post.id] = post.recent_comments
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @author_name = @post.author.name
  end
end
