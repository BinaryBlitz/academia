class Admin::BadgesController < Admin::AdminController
  before_action :set_badge, only: [:edit, :update, :destroy]

  def index
    @badges = Badge.all.page(params[:page])
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to @badge, notice: 'Иконка была успешно создана.'
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to @badge, notice: 'Иконка была успешно обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_url, notice: 'Иконка была успешно удалена.'
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:name, :image)
  end
end
