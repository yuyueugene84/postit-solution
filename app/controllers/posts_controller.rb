class PostsController < ApplicationController

  before_action :post_setup, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update] #has to be original creator or admin to edit post

  def index
    #binding.pry
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
    #params[:id] = current_user[:id]
    #@user = current_user
  end

  def show
    #binding.pry
    #instance variable means view template has access to it when you render
    @comment = Comment.new
    @comments = @post.comments.all.sort_by{|x| x.total_votes}.reverse

    respond_to do |format| #exposing api, applications talking to each other
      format.html
      format.json { render json: @post }
      format.xml {render xml: @post }
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create

    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Post created！"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Post updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
    
  end

  def destroy

  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted!'
        else
          flash[:error] = "You can only vote for <strong>#{@post.title}</strong> once!".html_safe
          #html_safe is for rails to evaluating output as html instead of string.
        end
        redirect_to :back
      end #end format
      format.js #rails default is going to render a template that has the same name as action
    end #end respond_to
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    #params.require(:categories).permit(:id)
  end

  def post_setup
    @post = Post.find_by slug: params[:id]
    #binding.pry
  end

  def require_creator
    #access_denied if logged_in? || (logged_in? and current_user != @post.creator)
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?) #better way of writing it
  end

end
