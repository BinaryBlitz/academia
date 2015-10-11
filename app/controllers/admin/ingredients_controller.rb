class Admin::IngredientsController < Admin::AdminController
  before_action :set_admin_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
  end

  def create
    @ingredient = Ingredient.new(admin_ingredient_params)

    if @ingredient.save
      redirect_to admin_ingredients_path, notice: 'Ingredient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ingredient.update(admin_ingredient_params)
      redirect_to admin_ingredients_path, notice: 'Ingredient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to admin_ingredients_url, notice: 'Ingredient was successfully destroyed.'
  end

  private

  def set_admin_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def admin_ingredient_params
    params.require(:ingredient).permit(:name, :image, :remove_image)
  end
end
