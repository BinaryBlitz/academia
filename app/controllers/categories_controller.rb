class CategoriesController < ApplicationController
  skip_before_action :restrict_access, only: [:index]

  def index
    @categories = Category.all
  end
end
