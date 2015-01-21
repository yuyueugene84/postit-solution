class CommentsController < ApplicationController
  def create
    #binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comments = @post.comments.all
    @comment.user_id = @post.user_id

    if @comment.save
      flash[:notice] = "Comment created！"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end

  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end

end

#redirect -> url
#render -> template file
