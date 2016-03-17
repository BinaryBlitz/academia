class HomeController < ApplicationController
  skip_before_filter :restrict_access

  def index
    render file: 'public/index.html' and return
  end
end
