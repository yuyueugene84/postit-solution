class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    #binding.pry
    @post = Post.find(params[:id])
    #instance variable means view template has access to it when you render
    render :show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


end
