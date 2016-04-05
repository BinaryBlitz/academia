class Admin::ReviewsController < Admin::AdminController
  def index
    @orders = Order.with_reviews.page(params[:page])
  end
end
