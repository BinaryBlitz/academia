class Admin::PromoCodesController < Admin::AdminController
  before_action :set_promo_code, only: [:edit, :update, :destroy]

  def index
    @promo_codes = PromoCode.all
  end

  def new
    @promo_code = PromoCode.new
  end

  def create
    @promo_code = PromoCode.new(promo_code_params)

    if @promo_code.save
      redirect_to admin_promo_codes_path, notice: 'Промо код создан.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @promo_code.update(promo_code_params)
      redirect_to admin_promo_codes_path, notice: 'Промо код обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @promo_code.destroy
    redirect_to admin_promo_codes_path, notice: 'Промо код удален.'
  end

  private

  def set_promo_code
    @promo_code = PromoCode.find(params[:id])
  end

  def promo_code_params
    params.require(:promo_code).permit(:code, :discount)
  end
end
