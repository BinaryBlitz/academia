class DishesController < ApplicationController
  def index
    @day = Day.today
    @dishes = @day.dishes
  end

  def lunches
    @dishes = Dish.where(lunch: true)
    render :index
  end

  def stuff
    @dishes = Dish.where(stuff: true)
    render :index
  end
end
