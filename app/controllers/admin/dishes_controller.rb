class Admin::DishesController < Admin::AdminController
  before_action :set_admin_dish, only: [:show, :edit, :update, :destroy]

  def index
    @dishes = Dish.all
  end

  def show
  end

  def new
    @dish = Dish.new
  end

  def edit
  end

  def create
    @dish = Dish.new(admin_dish_params)

    if @dish.save
      redirect_to [:admin, @dish], notice: 'Dish was successfully created.'
    else
      render :new
    end
  end

  def update
    if @dish.update(admin_dish_params)
      redirect_to [:admin, @dish], notice: 'Dish was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @dish.destroy
    redirect_to admin_dishes_url, notice: 'Dish was successfully destroyed.'
  end

  private

  def set_admin_dish
    @dish = Dish.find(params[:id])
  end

  def admin_dish_params
    params.require(:dish).permit(:name, :description, :price, :image, :remove_image, :stuff, :lunch)
  end
end
