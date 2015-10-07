class DaysController < ApplicationController
  before_action :set_day, only: [:show, :update, :destroy]

  def index
    @days = Day.all
  end

  def show
  end

  def create
    @day = Day.new(day_params)

    if @day.save
      render :show, status: :created, location: @day
    else
      render json: @day.errors, status: :unprocessable_entity
    end
  end

  def update
    if @day.update(day_params)
      head :no_content
    else
      render json: @day.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @day.destroy

    head :no_content
  end

  private

  def set_day
    @day = Day.find(params[:id])
  end

  def day_params
    params.require(:day).permit(:day_of_week)
  end
end
