class CommentsController < ApplicationController
  before_action :require_user, only:[:create, :vote]

  def create

    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    #binding.pry

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

  def vote
    #binding.pry

    @comment = Comment.find(params[:id])

    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    #binding.pry

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted!'
        else
          flash[:error] = "You can only vote for this comment once!".html_safe
          #html_safe is for rails to evaluating output as html instead of string.
        end
        redirect_to :back
      end #end format
      format.js
    end #end respond_to

  end

end

#redirect -> url
#render -> template file
