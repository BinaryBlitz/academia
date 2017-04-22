class API::EdgePointsController < API::APIController
  def index
    @edge_points = EdgePoint.all
  end
end
