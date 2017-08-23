class OrderMailer < ApplicationMailer
  ADMIN_EMAIL = Rails.application.secrets.admin_email

  def order_email(order)
    @order = order
    @user = order.user
    mail(to: [@user.email, ADMIN_EMAIL].compact, subject: "ZP receipt")
  end
end
