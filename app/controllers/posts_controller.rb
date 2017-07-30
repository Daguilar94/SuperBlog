class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new safe_params
    @post.user = current_user
    if @post.save
      redirect_to user_posts_path
    else
      render :new
    end
  end

  def update
    @post = Post.find params[:id]
    if @post.update safe_params
      redirect_to user_posts_path
    else
      render :edit
    end
  end

  def destroy
    del = Post.find params[:id]
    del.destroy
    redirect_to user_posts_path
  end

  def edit
    @post = Post.find params[:id]
  end

  protected
  def safe_params
      params.require(:post).permit(:title, :content)
  end
end
