class Admin::ExportsController < Admin::AdminController
  before_action :set_export, only: [:create]

  def index
  end

  def create
    send_data(@export.to_csv, filename: 'export.csv')
  end

  private

  def set_export
    @export = Export.new(params[:from], params[:to]) if params[:from].present? && params[:to].present?
    @export = Export.new(params[:from]) if params[:from].present?
    @export = Export.new
  end
end
