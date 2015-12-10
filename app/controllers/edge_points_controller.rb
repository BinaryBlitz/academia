class EdgePointsController < ApplicationController
  def index
    @edge_points = EdgePoint.all
  end
end
