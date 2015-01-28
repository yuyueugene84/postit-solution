class PostsController < ApplicationController

  before_action :post_setup, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    #binding.pry
    @posts = Post.all
    #params[:id] = current_user[:id]
    #@user = current_user
  end

  def show
    #binding.pry
    #instance variable means view template has access to it when you render
    @comment = Comment.new
    @comments = @post.comments
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


  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    #params.require(:categories).permit(:id)
  end

  def post_setup
    @post = Post.find(params[:id])
  end

end
