class CategoriesController < ApplicationController

  before_action :category_setup, :only => [:show, :edit, :update]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category created！"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated!"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category_setup
    @category = Category.find(params[:id])
  end

end