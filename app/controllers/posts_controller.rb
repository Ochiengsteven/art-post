class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts
    @recent_comments = {}

    @posts.each do |post|
      @recent_comments[post.id] = post.recent_comments
    end
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @comments = @post.comments
    @author_name = @post.author.name
    @comment = Comment.new
    @like = Like.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render 'users/show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to user_posts_path(current_user), notice: 'Post was deleted succesfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
