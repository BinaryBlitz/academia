class DishesController < ApplicationController
  before_action :set_dishes

  def index
  end

  def lunches
    render :index
  end

  def stuff
    render :index
  end

  private

  def set_dishes
    @day = Day.today
    @dishes = @day.dishes
  end
end
