class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_url, notice: 'Категория успешно созданa.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_url, notice: 'Категория было успешно обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Категория успешно удалена.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :complementary)
  end
end
