class Admin::DishesController < Admin::AdminController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  def index
    @dishes = Dish.dishes.page(params[:page])
  end

  def lunches
    @dishes = Dish.lunches.page(params[:page])
  end

  def stuff
    @dishes = Dish.stuff.page(params[:page])
  end

  def show
  end

  def new
    @dish = Dish.new(new_dish_params)
  end

  def edit
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to [:admin, @dish], notice: 'Блюдо успешно создано.'
    else
      render :new
    end
  end

  def update
    if @dish.update(dish_params)
      redirect_to [:admin, @dish], notice: 'Блюдо было успешно обновлено.'
    else
      render :edit
    end
  end

  def destroy
    @dish.destroy
    if @dish.lunch?
      redirect_to admin_lunches_url, notice: 'Ланч успешно удален.'
    elsif @dish.stuff
      redirect_to admin_stuff_url, notice: 'Дополнительное блюдо успешно удалено.'
    else
      redirect_to admin_dishes_url, notice: 'Блюдо успешно удалено.'
    end
  end

  private

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def new_dish_params
    params.permit(:stuff, :lunch)
  end

  def dish_params
    params.require(:dish)
          .permit(
            :name, :description, :subtitle, :price, :image, :remove_image, :stuff, :lunch, :hidden,
            dish_ingredients_attributes: [:id, :ingredient_id, :_destroy],
            dish_badges_attributes: [:id, :badge_id, :_destroy],
            lunch_dishes_attributes: [:id, :name, :weight, :_destroy]
          )
  end
end
