class CommentsController < ApplicationController
  def index
    post = Post.find params[:post_id]
    @comments = post.comments
    render :json => @comments, :include => [:user]
  end
  def create
    @comment = Comment.new (safe_params)
    @post = Post.find params[:post_id]
    @user = @post.user
    @comment.user_id = @user.id
    @comment.save
    @post.comments.push @comment
    redirect_to user_post_path(@user, @post)
  end

  protected
  def safe_params
      params.require(:comment).permit(:content, :post_id)
  end
end
