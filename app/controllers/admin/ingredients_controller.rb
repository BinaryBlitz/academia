class Admin::IngredientsController < Admin::AdminController
  before_action :set_admin_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = Ingredient.all.order(name: :asc)
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to admin_ingredients_path, notice: 'Ингридиент был успешно создан.'
    else
      render :new
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to admin_ingredients_path, notice: 'Ингридиент был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to admin_ingredients_url, notice: 'Ингридиент был успешно удален.'
  end

  private

  def set_admin_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :image, :remove_image)
  end
end
