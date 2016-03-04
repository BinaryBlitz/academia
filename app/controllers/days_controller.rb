class DaysController < ApplicationController
  skip_before_action :restrict_access, only: [:show]

  def show
    @day = Day.today
  end
end
