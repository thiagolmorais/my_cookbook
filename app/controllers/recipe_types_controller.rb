class RecipeTypesController < ApplicationController
  def index
    @recipe_types = RecipeType.all
  end

  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
    @recipe_types = RecipeType.all
    @recipes = Recipe.all
    @cuisines = Cuisine.all
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to recipe_type_path(RecipeType.last)
    else
      if @recipe_type.name?
        flash.now[:error] = 'O tipo de receita já está cadastrado'
        render :new
      else
        flash.now[:error] = 'Você deve informar o nome do tipo de receita'
        render :new
      end
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
