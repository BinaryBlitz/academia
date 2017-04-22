class Admin::ExportsController < Admin::AdminController
  before_action :set_export, only: [:create]

  def new
  end

  def create
    send_data(@export.to_csv, filename: 'export.csv')
  end

  private

  def set_export
    from = Date.parse(params[:from]) rescue nil
    to = Date.parse(params[:to]) rescue nil

    @export = Export.new(from, to) if from.present? && to.present?
    @export = Export.new(from) if from.present?
    @export = Export.new
  end
end
