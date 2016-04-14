class Admin::WelcomeScreenController < Admin::AdminController
  before_action :set_welcome_screen

  def show
  end

  def update
    if @welcome_screen.update(welcome_screen_params)
      redirect_to admin_welcome_screen_path, notice: 'Приветственный экран успешно обновлен.'
    else
      render :show
    end
  end

  private

  def set_welcome_screen
    @welcome_screen = WelcomeScreen.instance
  end

  def welcome_screen_params
    params.require(:welcome_screen)
      .permit(
        :image_open, :image_open_cache, :image_open_enabled,
        :image_closed, :image_closed_cache, :image_closed_enabled
      )
  end
end
