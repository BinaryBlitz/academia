class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :update, :destroy]

  def index
    @dishes = Dish.all
  end

  def show
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      render :show, status: :created, location: @dish
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dish.update(dish_params)
      head :no_content
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dish.destroy

    head :no_content
  end

  private

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :image)
  end
end
