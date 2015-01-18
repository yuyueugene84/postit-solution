class CommentsController < ApplicationController
  def create
    #binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
      if @comment.save
        flash[:success] = "Comment created！"
        redirect_to post_path(@post)
      else
        render 'posts/show'
      end
  end
end

#redirect -> url
#render -> template file
