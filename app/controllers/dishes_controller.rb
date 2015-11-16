class DishesController < ApplicationController
  def index
    @day = Day.today
    @dishes = @day.dishes
  end

  def stuff
    @dishes = Dish.where(stuff: true).visible
    render :index
  end
end
