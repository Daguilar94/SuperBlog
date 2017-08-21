class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find params[:id]
    @users = User.all
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new safe_params
    @post.user = current_user
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to user_posts_path
    else
      render :new
    end
  end

  def update
    @post = Post.find params[:id]
    if @post.update safe_params
      flash[:success] = "Post successfully updated"
      redirect_to user_posts_path
    else
      render :edit
    end
  end

  def destroy
    del_post = Post.find params[:id]
    del_coms = Comment.where("post_id = ?", params[:id])
    del_coms.each do |comment|
      comment.destroy
    end
    del_post.destroy
    flash[:success] = "Post successfully deleted"
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
