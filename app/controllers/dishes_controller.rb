class DishesController < ApplicationController
  skip_before_action :restrict_access, only: [:index]
  before_action :set_category, only: [:index]

  def index
    @day = Store.new.today
    if @day.present?
      @dishes = @day.dishes.includes(:schedules).where(schedules: { day: @day }).where(category: @category)
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
