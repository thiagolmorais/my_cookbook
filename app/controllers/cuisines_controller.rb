class CuisinesController < ApplicationController
  def index
    @cuisines = Cuisine.all
  end

  def show
    id = params[:id]
    @cuisine = Cuisine.find(id)
    @cuisines = Cuisine.all
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to cuisine_path(Cuisine.last)
    else
      flash.now[:error] = 'A cozinha já está cadastrada' if @cuisine.name?
      flash.now[:error] = 'Você deve informar o nome da cozinha' unless @cuisine.name?
      render :new
    end
  end

  def edit
    @cuisine = Cuisine.find(params[:id])
  end

  def update
    @cuisine = Cuisine.find(params[:id])
    if cuisine_params.value?('')
      flash.now[:error] = 'Você deve informar o nome da cozinha'
      render :edit
    elsif Cuisine.find_by(name: cuisine_params.values)
      flash.now[:error] = 'A cozinha já está cadastrada'
      render :edit
    else
      @cuisine = Cuisine.update(cuisine_params)
      redirect_to cuisine_path(Cuisine.last)
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
