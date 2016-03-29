class DishesController < ApplicationController
  def index
    @day = Store.new.today
    @dishes = @day.dishes
  end

  def stuff
    @dishes = Dish.where(stuff: true).visible
    render :index
  end
end
