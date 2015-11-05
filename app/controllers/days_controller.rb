class DaysController < ApplicationController
  def show
    @day = Day.today
  end
end
