class DishesController < ApplicationController
  before_action :set_category, only: [:index, :stuff]

  def index
    @day = Store.new.today
    @dishes = @day.dishes.where(category: @category)
  end

  def stuff
    @dishes = @category.dishes.where(stuff: true).visible
    render :index
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
