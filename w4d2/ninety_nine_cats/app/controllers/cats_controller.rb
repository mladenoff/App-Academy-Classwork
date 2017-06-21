class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    cat = Cat.find(params[:id])
    if cat.update(cat_params)
      redirect_to cat_url(params[:id])
    else
      redirect_to edit_cat(params[:id])
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
