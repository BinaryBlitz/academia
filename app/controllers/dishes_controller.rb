class DishesController < ApplicationController
  skip_before_action :restrict_access, only: [:index]
  before_action :set_category, only: [:index]

  def index
    @day = Store.new.today
    @dishes = @day.dishes.with_schedules_on_day(@day).where(category: @category)
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
